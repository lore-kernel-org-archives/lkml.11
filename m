Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B735DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 03:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344294AbiEDD24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 23:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344245AbiEDD2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 23:28:35 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AD2275FF
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:25:00 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 23-20020a630117000000b003c5ea4365a1so101847pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 20:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zKCKCgAwM5oT8CgO5VNyRlj8I6pySWAhtN3tpf4n6dA=;
        b=ZM4FeKDUCZJiRyb6P789sMyqQSdZxP9XlE+XolrTRJung6jURrvaZ4TkCOnYGXplWq
         pivLdmaf4E5Z3zW+JY2SABmk/EOjm8hMWmuvKJVfiiGdB7KLHJDAJtHrlmN86QnZTqaz
         l0GNTroDwFS/uemQ9HeUoMAESGig2H42S+rLP9tOzEabemDBnqW9mEDfxrIqb6gDCu4Z
         0P0BsGmF0zmkiOpJVOM8fR6uaDViEBbGGd7tcr/zne9m8oLreGewDVc/ADcEmTvP3EO5
         hSXxOqRot+NCfGhNbQk0PT1eMb8gEXcXn1nt7AWnFAzDhdTznxulALBdDtim9UytX31t
         6YQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zKCKCgAwM5oT8CgO5VNyRlj8I6pySWAhtN3tpf4n6dA=;
        b=QS5o6gkrAHDg9dJVyBxfF83uz9kimDs4HhzBS6LkDkRq3xGxgG8mc4akMONQHO66eU
         Uvn60mJm4VZeJQYJ39wne+d9cZrWot1q4dJvtmc4zUt6inNMfd3x1NMMAj0bWTWWIC3h
         +oNMkx2GljWuIcJhG4rRT0lX5FvWVHsjw7E/1R5W3QD5tfuUUHhUw8T+w8hoeMwTeIpS
         Zbvk0jPcWCDPQxFb6DwoSGpUbqWn3DYbH85UsDKzH3kBjN1vtxpVeDJR2ImGd0zlI9HA
         ONoWzglkS3gvwZuHSk0wCJwPbuYKAfWZvuWu2UTgNLY/kpiJfMIPGvgZ8DMVSYCQqGY4
         1NBA==
X-Gm-Message-State: AOAM533jDr2pBVKfWKNyrOMfv8TP4/lyubl842/70U+uIC8VD6Olel5k
        QdLmcw6I6SMVYEzn5FTaNdEHFNRQkgc=
X-Google-Smtp-Source: ABdhPJzP/+HQx4zfHUjvoSoNur8GO2K6JD7rMAYer4k1x860wsfHvr/21vl0vtL9uuPVV77+Bqvb3zMQemE=
X-Received: from oupton3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:21eb])
 (user=oupton job=sendgmr) by 2002:a05:6a00:1312:b0:4e1:58c4:ddfd with SMTP id
 j18-20020a056a00131200b004e158c4ddfdmr19149872pfu.65.1651634700423; Tue, 03
 May 2022 20:25:00 -0700 (PDT)
Date:   Wed,  4 May 2022 03:24:38 +0000
In-Reply-To: <20220504032446.4133305-1-oupton@google.com>
Message-Id: <20220504032446.4133305-5-oupton@google.com>
Mime-Version: 1.0
References: <20220504032446.4133305-1-oupton@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v6 04/12] KVM: arm64: Rename the KVM_REQ_SLEEP handler
From:   Oliver Upton <oupton@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        reijiw@google.com, ricarkol@google.com,
        Oliver Upton <oupton@google.com>,
        Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The naming of the kvm_req_sleep function is confusing: the function
itself sleeps the vCPU, it does not request such an event. Rename the
function to make its purpose more clear.

No functional change intended.

Signed-off-by: Oliver Upton <oupton@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 arch/arm64/kvm/arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 29e107457c4d..77b8b870c0fc 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -594,7 +594,7 @@ void kvm_arm_resume_guest(struct kvm *kvm)
 	}
 }
 
-static void vcpu_req_sleep(struct kvm_vcpu *vcpu)
+static void kvm_vcpu_sleep(struct kvm_vcpu *vcpu)
 {
 	struct rcuwait *wait = kvm_arch_vcpu_get_wait(vcpu);
 
@@ -652,7 +652,7 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 {
 	if (kvm_request_pending(vcpu)) {
 		if (kvm_check_request(KVM_REQ_SLEEP, vcpu))
-			vcpu_req_sleep(vcpu);
+			kvm_vcpu_sleep(vcpu);
 
 		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
 			kvm_reset_vcpu(vcpu);
-- 
2.36.0.464.gb9c8b46e94-goog

