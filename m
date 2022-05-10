Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70826C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 16:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346572AbiEJRAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346568AbiEJRAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 079942878F8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652201801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kg5B6ZyXTHSbDVCByrs97zs5DDN5Y0oVpgwrU2sIps=;
        b=Q61RXm81JrW2lJe1f0kcZySZ9z4KnMXmWj4kGLRR18YBLRpkMnBzK3spnX7pdM9S3amcaE
        y9pfTcEtU0OttjHxMee0tt1AsXu/9H0FvtxtcCgdZUHcWwO32xfX0svxh1Qq4IwtAxxu52
        DjIMSCQ/lXKVr3xW8BWOoQzJZzhK0as=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-37XaK59MPAaFxVdMWMuHaQ-1; Tue, 10 May 2022 12:56:38 -0400
X-MC-Unique: 37XaK59MPAaFxVdMWMuHaQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 572C31C06EDE;
        Tue, 10 May 2022 16:56:37 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B34029D7E;
        Tue, 10 May 2022 16:56:36 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH RESEND v12 00/17] KVM: x86/pmu: Add basic support to enable guest PEBS via DS
Date:   Tue, 10 May 2022 12:55:06 -0400
Message-Id: <20220510165505.217414-1-pbonzini@redhat.com>
In-Reply-To: <20220411101946.20262-1-likexu@tencent.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks, but only because I have not done my job very well
in handling this patch series (and LBR too) and I feel bad about
it.  Sending such a large patch series with no kvm-unit-tests should
not happen, and I'd be grateful if you wrote testcases after the fact.

Paolo


