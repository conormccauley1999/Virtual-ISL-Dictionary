﻿using System.Linq;
using UnityEngine;

public class HandController : MonoBehaviour {
    
    [Header("Model Position")]
    public Vector3 modelPosition;
    
    [Header("Hand/Arm Positions")]
    public Overall.Position overallPosition = Overall.Position.Anterior;
    public Forearm.Position forearmPosition = Forearm.Position.Standard;
    public Hand.Position handPosition = Hand.Position.Standard;
    
    [Header("Finger Positions")]
    public Thumb.Position thumbPosition = Thumb.Position.ExtensionAdduction;
    public Index.Position indexPosition = Index.Position.ExtensionAdduction;
    public Middle.Position middlePosition = Middle.Position.ExtensionAdduction;
    public Ring.Position ringPosition = Ring.Position.ExtensionAdduction;   
    public Pinky.Position pinkyPosition = Pinky.Position.ExtensionAdduction;
    
    public void Update() {
        UpdateOverall(overallPosition, modelPosition);
        UpdateThumb(thumbPosition);
        UpdateIndex(indexPosition);
        UpdateMiddle(middlePosition);
        UpdateRing(ringPosition);
        UpdatePinky(pinkyPosition);
        UpdateHand(handPosition);
        UpdateForearm(forearmPosition);
    }

    public void Reset() {
        UpdateOverall(Overall.GetResetPosition(), Overall.GetResetModelPosition());
        UpdateThumb(Thumb.GetResetPosition());
        UpdateIndex(Index.GetResetPosition());
        UpdateMiddle(Middle.GetResetPosition());
        UpdateRing(Ring.GetResetPosition());
        UpdatePinky(Pinky.GetResetPosition());
        UpdateHand(Hand.GetResetPosition());
        UpdateForearm(Forearm.GetResetPosition());
    }

    public void ImportPosition(string filePath) {   

        Encoding encoding = EncodingController.Decode(filePath);
        Keyframe keyframe = encoding.keyframes[0]; // just use the first keyframe for now
        
        modelPosition = new Vector3(keyframe.modelPosition.x, keyframe.modelPosition.y, keyframe.modelPosition.z);
        overallPosition = (Overall.Position) keyframe.overall;
        thumbPosition = (Thumb.Position) keyframe.thumb;
        indexPosition = (Index.Position) keyframe.index;
        middlePosition = (Middle.Position) keyframe.middle;
        ringPosition = (Ring.Position) keyframe.ring;
        pinkyPosition = (Pinky.Position) keyframe.pinky;
        handPosition = (Hand.Position) keyframe.hand;
        forearmPosition = (Forearm.Position) keyframe.forearm;

        Update();

    }

    public void ExportPosition(string filePath) {
        // To-do
    }

    private void UpdateOverall(Overall.Position position, Vector3 _modelPosition) {

        if (overallPosition != position)
            overallPosition = position;
        
        if (modelPosition != _modelPosition)
            modelPosition = _modelPosition;

        var joints = Overall.Joint.GetValues(typeof(Overall.Joint)).Cast<Overall.Joint>();

        foreach (var joint in joints) {
            string jointName = Overall.GetJointName(joint);
            GameObject.Find(jointName).transform.localEulerAngles = Overall.GetJointRotationInPosition(position, joint);
        }

        GameObject.Find(Overall.GetModelName()).transform.position = _modelPosition;

    }

    private void UpdateThumb(Thumb.Position position) {

        if (thumbPosition != position)
            thumbPosition = position;

        var joints = Thumb.Joint.GetValues(typeof(Thumb.Joint)).Cast<Thumb.Joint>();

        foreach (var joint in joints) {
            string jointName = Thumb.GetJointName(joint);
            GameObject.Find(jointName).transform.localEulerAngles = Thumb.GetJointRotationInPosition(position, joint);
        }

    }

    private void UpdateIndex(Index.Position position) {

        if (indexPosition != position)
            indexPosition = position;

        var joints = Index.Joint.GetValues(typeof(Index.Joint)).Cast<Index.Joint>();

        foreach (var joint in joints) {
            string jointName = Index.GetJointName(joint);
            GameObject.Find(jointName).transform.localEulerAngles = Index.GetJointRotationInPosition(position, joint);
        }

    }

    private void UpdateMiddle(Middle.Position position) {

        if (middlePosition != position)
            middlePosition = position;

        var joints = Middle.Joint.GetValues(typeof(Middle.Joint)).Cast<Middle.Joint>();

        foreach (var joint in joints) {
            string jointName = Middle.GetJointName(joint);
            GameObject.Find(jointName).transform.localEulerAngles = Middle.GetJointRotationInPosition(position, joint);
        }

    }

    private void UpdateRing(Ring.Position position) {

        if (ringPosition != position)
            ringPosition = position;

        var joints = Ring.Joint.GetValues(typeof(Ring.Joint)).Cast<Ring.Joint>();

        foreach (var joint in joints) {
            string jointName = Ring.GetJointName(joint);
            GameObject.Find(jointName).transform.localEulerAngles = Ring.GetJointRotationInPosition(position, joint);
        }

    }

    private void UpdatePinky(Pinky.Position position) {

        if (pinkyPosition != position)
            pinkyPosition = position;

        var joints = Pinky.Joint.GetValues(typeof(Pinky.Joint)).Cast<Pinky.Joint>();

        foreach (var joint in joints) {
            string jointName = Pinky.GetJointName(joint);
            GameObject.Find(jointName).transform.localEulerAngles = Pinky.GetJointRotationInPosition(position, joint);
        }

    }

    private void UpdateHand(Hand.Position position) {

        if (handPosition != position)
            handPosition = position;

        var joints = Hand.Joint.GetValues(typeof(Hand.Joint)).Cast<Hand.Joint>();

        foreach (var joint in joints) {
            string jointName = Hand.GetJointName(joint);
            GameObject.Find(jointName).transform.localEulerAngles = Hand.GetJointRotationInPosition(position, joint);
        }

    }

    private void UpdateForearm(Forearm.Position position) {

        if (forearmPosition != position)
            forearmPosition = position;

        var joints = Forearm.Joint.GetValues(typeof(Forearm.Joint)).Cast<Forearm.Joint>();

        foreach (var joint in joints) {
            string jointName = Forearm.GetJointName(joint);
            GameObject.Find(jointName).transform.localEulerAngles = Forearm.GetJointRotationInPosition(position, joint);
        }

    }

}
