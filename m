Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DB8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 10:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiGDKfg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 06:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiGDKfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729B5E0C9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D86B36158B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7868CC3411E;
        Mon,  4 Jul 2022 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656930931;
        bh=YMgEwaarHlXVWxjbc1utp5BF4lA79Mt080X8k4FjCYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPSaWbzxucd8Yz8sGU7fyaytLBrFev31claPyi2lkjBaXQd55HBvjSihl7PkBmDqO
         ofpJxBJ+b/QhJLmyFBQunt17/y86AxhXFZZx96FosVZHh5aLv8LL1I/+BDml9c//Ta
         8BtvCBKMpGz8krQOay7Y8hE9MAQAuNy/0oh86gl9SPRgSstIJflRb3uxrs4iFFXhIj
         +pU4MCVIOnvvFZyPDIaxw9zMokrijg1qIp/Hhf7h66hxBeoY0OfD6vBmXQWNB2vvp+
         Mw6fBvedo6bj4Z3+xXqVymB1t6fEfkqbgaFAXw1BuNts6o4NdcGt2OSh4kbglu61oK
         2Dgz524F6qKdw==
Date:   Mon, 4 Jul 2022 11:35:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
Message-ID: <20220704103523.GC31437@willie-the-truck>
References: <1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 11:57:53PM +0800, Guanghui Feng wrote:
> The arm64 can build 2M/1G block/sectiion mapping. When using DMA/DMA32 zone
> (enable crashkernel, disable rodata full, disable kfence), the mem_map will
> use non block/section mapping(for crashkernel requires to shrink the region
> in page granularity). But it will degrade performance when doing larging
> continuous mem access in kernel(memcpy/memmove, etc).

Hmm. It seems a bit silly to me that we take special care to unmap the
crashkernel from the linear map even when can_set_direct_map() is false, as
we won't be protecting the main kernel at all!

Why don't we just leave the crashkernel mapped if !can_set_direct_map()
and then this problem just goes away?

Will
