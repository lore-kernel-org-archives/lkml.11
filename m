Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADEEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 17:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiCIRP5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 12:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbiCIROR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:14:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 986D012F152
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646845771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z7l/xDj4zR793YWwmTzG872Z4EQ0qUiIYr9YimYADHc=;
        b=F2wWNTvoK73UK7w00EuZ/50f29GLTSfLUH+OTSMPAQgMb+tJMvZ7Fp2wKSKacCdYMfnM/L
        WgxJ/21qdT7e68t1Ona8IZe3CoRySU6ievyNbPVIlChIVWAf+Dq3YiRTXB+O5Vk2VIl4by
        TCwrncORC0Cj7jFJ/REFC5V6P1LV5Eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-kqkdZMLKNZC7FCoE81vQNg-1; Wed, 09 Mar 2022 12:09:30 -0500
X-MC-Unique: kqkdZMLKNZC7FCoE81vQNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38323801AFE;
        Wed,  9 Mar 2022 17:09:29 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C62F886B8F;
        Wed,  9 Mar 2022 17:09:28 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, jmattson@google.com
Subject: [PATCH 0/2] KVM: x86: add support for CPUID leaf 0x80000021
Date:   Wed,  9 Mar 2022 12:09:26 -0500
Message-Id: <20220309170928.1032664-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUID leaf 0x80000021 defines some features (or lack of bugs) of AMD
processors.  This small series implements it, and also synthesizes
for use on processors that do not have the "Null selector clear base"
erratum but do not support the leaf 0x80000021 either.

Paolo

Paolo Bonzini (2):
  KVM: x86: add support for CPUID leaf 0x80000021
  KVM: x86: synthesize CPUID leaf 0x80000021h if useful

 arch/x86/kvm/cpuid.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

-- 
2.31.1

