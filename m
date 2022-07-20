Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C34AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 07:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbiGTHrh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 03:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiGTHrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:47:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E8A5070B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B8A86195B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83989C3411E;
        Wed, 20 Jul 2022 07:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658303250;
        bh=8+hzqNPjV7peyBDoo9m+CnxyhBwRD1PxUkUfBn6uySQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ro3M9+tMC8JFKBmYQfZWLR3qz58Qzc7uP9ptlqP6A8F3PnSu9gkfRdKXyWHLUQC0E
         kacaVCdd2dy+56lW8RqxCjXnjfy4hRS1spzbUKZKxC35tosYAFES3/EHDwZdZtn7Wz
         rIiGY28y2Cxa+EXuc5mJS+oMZCcyxAwYtpj3qc0Scs2/09V197v3v/nvvCQ9flVuZz
         hR6Bua8VQy+2CZDq45uCkCiqC53QGhbNQt+MtPglwSaEyuIdwy3hHy2gGBJzAD+JSb
         7GrTfulG1B2vqCW+3waWEonWjhYZrRu/B7WVt17MwhIh6AiVfXrRhalsceQ924WyS6
         gPhVjVXm2rD9g==
Date:   Wed, 20 Jul 2022 10:47:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] memblock tests: change build options to run-time options
Message-ID: <YtezAlzZHRgeMeGe@kernel.org>
References: <20220714031717.12258-1-remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714031717.12258-1-remckee0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 10:17:17PM -0500, Rebecca Mckeever wrote:
> Change verbose and movable node build options to run-time options.
> 
> Movable node usage:
>     $ ./main -m
> 
>     Or:
>     $ ./main --movable-node
> 
> Verbose usage:
>     $ ./main -v
> 
>     Or:
>     $ ./main --verbose
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  tools/testing/memblock/Makefile               |  5 --
>  tools/testing/memblock/linux/memory_hotplug.h |  8 +-
>  tools/testing/memblock/main.c                 |  2 +
>  .../testing/memblock/scripts/Makefile.include | 10 ---
>  tools/testing/memblock/tests/common.c         | 86 ++++++++++++++++---
>  tools/testing/memblock/tests/common.h         | 10 +--
>  6 files changed, 79 insertions(+), 42 deletions(-)

Applied, thanks!

-- 
Sincerely yours,
Mike.
