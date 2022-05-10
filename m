Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED66C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 15:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345635AbiEJPYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345583AbiEJPWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC46A87A37
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652195239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fI2ZawHCdRIhMJCwYHvAzY/bTTBNnIpXKClvdmq4TdY=;
        b=gZXCG5neXk185hfHF6RuHNsb5nIATlH9fd1PF7gtEVJLeEScZweq5iBvxwW+QDca4KXTG4
        UC3QHYV1pLP2/vexs9ntbsKgLZvSNu+yU7LHsrcD7Si+X/wJpVs+nylUdT7NsMlvxrfBML
        QOT9DIn4tXwl+nlvLKCC+jRKDd3mjMg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-caOQUNsuOAqj1TuHv_ir7A-1; Tue, 10 May 2022 11:07:16 -0400
X-MC-Unique: caOQUNsuOAqj1TuHv_ir7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF6F43C021AB;
        Tue, 10 May 2022 15:07:15 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72BB89E72;
        Tue, 10 May 2022 15:07:15 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, likexu@tencent.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: x86: Skip unsupported test when Arch LBR is available
Date:   Tue, 10 May 2022 11:06:38 -0400
Message-Id: <20220510150637.1774645-1-pbonzini@redhat.com>
In-Reply-To: <20220510035028.21042-1-weijiang.yang@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -	ret = _vcpu_set_msr(vm, 0, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_LBR_FMT);
> -	TEST_ASSERT(ret == 0, "Bad PERF_CAPABILITIES didn't fail.");
> +	/* Note, on Arch LBR capable platforms, LBR_FMT in perf capability msr is 0x3f,
> +	 * so skip below test if running on these platforms. */
> +	if (host_cap.lbr_format != PMU_CAP_LBR_FMT) {
> +		ret = _vcpu_set_msr(vm, 0, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_LBR_FMT);
> +		TEST_ASSERT(ret == 0, "Bad PERF_CAPABILITIES didn't fail.");
> +	}

Why not try a different value?

Paolo


