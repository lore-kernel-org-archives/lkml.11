Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAD5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 16:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbiEaQ5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiEaQ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:57:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F091D338
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE29060DFD
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BE0C34114;
        Tue, 31 May 2022 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654016237;
        bh=OAsO/LDcILzsEYb7Ai+a+cFkwhmI78SSd8v+OAbhhmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cw6Cl91tM514+EB8xrik4iPkzjJgRrMM1pZnMZo55VT8zieiuYdS66MhIrmbBp9Jm
         XODXUoxP068OSfkzpTu8v9a6/DL6imlDZ6pwnUVUMQkaSQYcN4mnLj8lTOXdRvSxBr
         bhKt5PZddhw1LkFrsWtcHWxtzzIAYxZ/BQRrTreRFXnK7aJdYIUIR1ITugUWJhM3QS
         OtesMoaNRwMPuVS73YThb5ZAzhlBuBtIt7BYTrh2zJjdF9Q52mpTLU+nvoOav0rLQf
         HqXkQ5gNqshdEX3zIEqCIlHw6xTLNrdEecGsH93r4aoaUlyLk18peKdzTJxDHfA3cq
         EYFAj7IKjzfmw==
Date:   Tue, 31 May 2022 17:57:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix memory leaks from stage2 pagetable
Message-ID: <20220531165710.GB25631@willie-the-truck>
References: <20220526203956.143873-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526203956.143873-1-quic_qiancai@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 04:39:56PM -0400, Qian Cai wrote:
> Running some SR-IOV workloads could trigger some leak reports from
> kmemleak.
> 
> unreferenced object 0xffff080243cef500 (size 128):
>   comm "qemu-system-aar", pid 179935, jiffies 4298359506 (age 1629.732s)
>   hex dump (first 32 bytes):
>     28 00 00 00 01 00 00 00 00 e0 4c 52 03 08 ff ff  (.........LR....
>     e0 af a4 7f 7c d1 ff ff a8 3c b3 08 00 80 ff ff  ....|....<......
>   backtrace:
>      kmem_cache_alloc_trace
>      kvm_init_stage2_mmu

Hmm, I can't spot a 128-byte allocation in here so this is pretty cryptic.
I don't really like the idea of papering over the report; we'd be better off
trying to reproduce it.

Will
