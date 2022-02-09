Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF865C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 13:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiBINdc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 08:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiBINd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:33:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF28C0613C9;
        Wed,  9 Feb 2022 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qNFeZbXeaZKk85n28kZlF4G4XFUL/pGDhSDIhAQszpM=; b=MTJjgBhtdTUnuAO1JGOZdtaUFs
        I+2ttLT4l44z55HYhUvItVJwzExq3r+CcY7FaRbcUrDFxWqDPX+383xbP81pPo8EuNtgAmmdt7Kkk
        MQiulzsU1wXPVBIDC5jxd1018017hSETE+Gvq6rGROczOxSvMgOuJ1jmbXdaCmf/CwPmlACW06zf+
        kL2gsdV/NblV/RHvuDRwXYcg5RwFWiHKYUBwKadHengfLf5RnaaF7Tcs4nB7pZKCbTDcJJD2SflLc
        gxPEMN6FB4MNJE7IqckLyyUZXN1yRmKc+5r/CYRGiQjpWuOn0xPvSVoygaQHD703zudw6MrzjlKQJ
        cSEspMLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHn5w-007ntX-Dp; Wed, 09 Feb 2022 13:33:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6E99300478;
        Wed,  9 Feb 2022 14:33:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 905EF201BECDA; Wed,  9 Feb 2022 14:33:15 +0100 (CET)
Date:   Wed, 9 Feb 2022 14:33:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        David Dunn <daviddunn@google.com>
Subject: Re: KVM: x86: Reconsider the current approach of vPMU
Message-ID: <YgPCm1WIt9dHuoEo@hirez.programming.kicks-ass.net>
References: <20220117085307.93030-1-likexu@tencent.com>
 <20220117085307.93030-3-likexu@tencent.com>
 <20220202144308.GB20638@worktop.programming.kicks-ass.net>
 <CALMp9eRBOmwz=mspp0m5Q093K3rMUeAsF3vEL39MGV5Br9wEQQ@mail.gmail.com>
 <2db2ebbe-e552-b974-fc77-870d958465ba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db2ebbe-e552-b974-fc77-870d958465ba@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 04:10:48PM +0800, Like Xu wrote:
> On 3/2/2022 6:35 am, Jim Mattson wrote:
> > 3) TDX is going to pull the rug out from under us anyway. When the TDX
> > module usurps control of the PMU, any active host counters are going
> > to stop counting. We are going to need a way of telling the host perf
> 
> I presume that performance counters data of TDX guest is isolated for host,
> and host counters (from host perf agent) will not stop and keep counting
> only for TDX guests in debug mode.

Right, lots of people like profiling guests from the host. That allows
including all the other virt gunk that supports the guest.

Guests must not unilaterally steal the PMU.

> At one time, we proposed to statically reserve counters from the host
> perf view at guest startup, but this option was NAK-ed from PeterZ.

Because counter constraints, if you hand C0 to the guest, the host
can no longer count certain events, which is bad.
