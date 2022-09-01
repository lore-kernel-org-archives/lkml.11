Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4210ECAAD3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 23:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbiIAXMm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 19:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbiIAXMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F65A7AC04
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662073953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=FgSIJI6gSNLf7R6jbBEPnnMGlEQKrun+TyOAMO/UNDN1NGEpI3N9UBEifVrc1l11vV5PiC
        00WQ0ovLa16Yutw64jqX8gRan7ShhcN37f6u3ppGiLOMh3PfBSCVHiA+XN7Eu7va8BElc3
        g6ioZvmZw35WNhpdBP/VPlj19ig6mh8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-_tXKcoiGPXSeH5V407o_IQ-1; Thu, 01 Sep 2022 19:12:29 -0400
X-MC-Unique: _tXKcoiGPXSeH5V407o_IQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0BC2800124;
        Thu,  1 Sep 2022 23:12:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48A40492C3B;
        Thu,  1 Sep 2022 23:12:28 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: fix memoryleak in kvm_arch_vcpu_create()
Date:   Thu,  1 Sep 2022 19:12:25 -0400
Message-Id: <20220901231225.3887196-1-pbonzini@redhat.com>
In-Reply-To: <20220901122300.22298-1-linmiaohe@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo


