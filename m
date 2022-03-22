Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE9DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 08:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiCVIKE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 04:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiCVIJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 199D55A5B6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647936498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hhCVxnMMhxOLAoQ7CT56ngfiw6zvDll/EwZY6fngGZg=;
        b=YRsiklvnVTBdwT8mNY7KiZ4Hik7rVoFmkcp9IPbxEnUbn3eARCcYiHC2nV01YHcjkWpxOi
        CWF2cH3HVATlmAZS58Do5cvjuPFn8b/8hMJDgtkz4e/G4QrF3hKBlu4bRJUzim19nWCq9w
        E+QbBcyPwL417YPrdZVlAzGll/ZHbDU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-GRq1ZWpqOvKw7cQW1QWGrQ-1; Tue, 22 Mar 2022 04:08:14 -0400
X-MC-Unique: GRq1ZWpqOvKw7cQW1QWGrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26ACC38041CE;
        Tue, 22 Mar 2022 08:08:14 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 187621121325;
        Tue, 22 Mar 2022 08:08:07 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com,
        shannon.zhaosl@gmail.com, maz@kernel.org,
        Jonathan.Cameron@huawei.com, will@kernel.org, pbonzini@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, drjones@redhat.com,
        vkuznets@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 03/22] KVM: arm64: Support SDEI_VERSION hypercall
Date:   Tue, 22 Mar 2022 16:06:51 +0800
Message-Id: <20220322080710.51727-4-gshan@redhat.com>
In-Reply-To: <20220322080710.51727-1-gshan@redhat.com>
References: <20220322080710.51727-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_VERSION hypercall by returning v1.1, which is
the specification version we're following. The vendor is set to
'KVM'.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 8a9b477b8977..5a3a64cd6e84 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -118,6 +118,14 @@ static bool remove_all_vcpu_events(struct kvm_vcpu *vcpu,
 	return pending;
 }
 
+static unsigned long hypercall_version(struct kvm_vcpu *vcpu)
+{
+	/* v1.1 and the vendor is KVM */
+	return (1UL << SDEI_VERSION_MAJOR_SHIFT) |
+	       (1UL << SDEI_VERSION_MINOR_SHIFT) |
+	       0x4b564d;
+}
+
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -142,6 +150,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 
 	switch (func) {
 	case SDEI_1_0_FN_SDEI_VERSION:
+		ret = hypercall_version(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
 	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
 	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
-- 
2.23.0

