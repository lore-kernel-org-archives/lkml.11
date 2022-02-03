Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5FAC433FE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Feb 2022 10:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350135AbiBCKqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Feb 2022 05:46:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234122AbiBCKqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643885199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KznM2brLVbcVLIIbiG/YDm1i0bYWkL1/aumxLYc+qUY=;
        b=YmZAwWRg9jqB+bG2a39ZLyG15LcQ6UAU1GREnp4cmNYI9Ri0x0VXVdTvk87sBqFi3M5blx
        6n3yAXb6SnF6tclSSkshQsxIvzv3/MIPqpij08eM/nZQAkvo2iCyWAcvakmBr/FT1J8PTN
        8u45arkcrJGpsKK6hiKtIiE3kMd2k3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-4qQN6ZYpP4SH7NjY7JHkLA-1; Thu, 03 Feb 2022 05:46:36 -0500
X-MC-Unique: 4qQN6ZYpP4SH7NjY7JHkLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E14046860;
        Thu,  3 Feb 2022 10:46:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41F33108B4;
        Thu,  3 Feb 2022 10:46:32 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] KVM: selftests: nSVM: Update 'struct vmcb_control_area' definition
Date:   Thu,  3 Feb 2022 11:46:19 +0100
Message-Id: <20220203104620.277031-6-vkuznets@redhat.com>
In-Reply-To: <20220203104620.277031-1-vkuznets@redhat.com>
References: <20220203104620.277031-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a copy of 'struct vmcb_control_area' definition in KVM selftests,
update it to allow testing of the newly introduced features.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/include/x86_64/svm.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/svm.h b/tools/testing/selftests/kvm/include/x86_64/svm.h
index f4ea2355dbc2..2225e5077350 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm.h
@@ -99,7 +99,14 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u8 reserved_6[8];	/* Offset 0xe8 */
 	u64 avic_logical_id;	/* Offset 0xf0 */
 	u64 avic_physical_id;	/* Offset 0xf8 */
-	u8 reserved_7[768];
+	u8 reserved_7[8];
+	u64 vmsa_pa;		/* Used for an SEV-ES guest */
+	u8 reserved_8[720];
+	/*
+	 * Offset 0x3e0, 32 bytes reserved
+	 * for use by hypervisor/software.
+	 */
+	u8 reserved_sw[32];
 };
 
 
-- 
2.34.1

