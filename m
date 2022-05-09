Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0054C4332F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 10:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiEIKUC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 06:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiEIKTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10CF132776
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 057F760B00
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 10:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55607C385A8;
        Mon,  9 May 2022 10:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652091342;
        bh=sxUAcaLLSaqfGpbMutvCvdhAXxJ4xVgqlea0hGl2N/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lF1n9cNupiZV2/RLcE7nDILUkQhSJRmxMAUfJkQ/3qwJApfB67NfGjxqkLCycdIQp
         eUCCr1JihRwQcZCsMQtMwB6IhkdXgwWESy8evcTcjym6MUkAydKkJ3PQDkVdLd93Si
         LLAJRWR+qcxzAWO0zE6jvpLsXghuI5rM2r31PW+yJ99zq2NcAYGYRt1CqHH4DlI1gM
         7XBnl+xlhAKYbeQRqj2GZnQ63nRne2DAfGWEVqLQl4LYjSWCvygzdwrdr4tq0KcPeN
         FglTk7c6PXJvhnb9+vcht95w4eVyWseydSkyBFkPPlUnWinAVLjttWXDuGNlHHmS3T
         7hDBmtEYnziwg==
Date:   Mon, 9 May 2022 13:15:35 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 0/5] memblock tests: update style of comments
Message-ID: <Ynjpx8wVOMMEo2r2@kernel.org>
References: <cover.1651357434.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651357434.git.remckee0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 05:49:35PM -0500, Rebecca Mckeever wrote:
> These patches update the style of comments for memblock_add_*(),
> memblock_reserve_*(), memblock_remove_*(), and memblock_free_*()
> functions to match the style of comments in tests/alloc_*.c and
> remove extra spaces in those comments to conform to Linux kernel
> coding style. This completes an item from the TODO list.
> 
> Rebecca Mckeever (5):
>   memblock tests: update style of comments for memblock_add_*()
>     functions
>   memblock tests: update style of comments for memblock_reserve_*()
>     functions
>   memblock tests: update style of comments for memblock_remove_*()
>     functions
>   memblock tests: update style of comments for memblock_free_*()
>     functions
>   memblock tests: remove completed TODO item
> 
>  tools/testing/memblock/TODO              |   3 -
>  tools/testing/memblock/tests/basic_api.c | 392 ++++++++++++++++-------
>  2 files changed, 278 insertions(+), 117 deletions(-)

Applied, thanks!
 
-- 
Sincerely yours,
Mike.
