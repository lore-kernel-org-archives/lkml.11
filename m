Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2BEC28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 16:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiHVQ4y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiHVQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:56:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382EA3E749;
        Mon, 22 Aug 2022 09:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8FEFB81626;
        Mon, 22 Aug 2022 16:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6DDC433C1;
        Mon, 22 Aug 2022 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661187408;
        bh=yG8d1dzyQST9Nceswgh4cW2/OcjGtdAH7IEPeUEqOy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoQfGOUiFiLncCeoBzrbxInqVBWgYP45hq6yWuJ990bZwT9xuCOe9mLb/g8Q+UsYe
         cjiAyLJIyZr4xMQgUkLU4lvigOXn3hZkgQDCLdWT0GcgUcPZbE3pNLXT58PIhHLGfP
         161mLjRnusGpvABoqDTQkw27oeGrmvK5y3S484OJb1vsWb7SLD2nf/NfaX5s8w2GLA
         kb5hs3+REKuD90Pe841+BC+QDjE88TiO8pUfhWL8wqPhYy/cpDzThfnh0eegAbccj9
         MKwT95ERzERMKSWWEj/w2ppI7CMeGg0Dq/NvH8EZjUjaiWQycEvz0gOpHWhz2MBdzy
         vYmU6OfuzFStw==
From:   SeongJae Park <sj@kernel.org>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     damon@lists.linux.dev, SeongJae Park <sj@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/usage: fix the example code snip
Date:   Mon, 22 Aug 2022 16:56:46 +0000
Message-Id: <20220822165646.87524-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822105617.75524-1-ryncsn@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kairui,


On Mon, 22 Aug 2022 18:56:17 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> From: Kairui Song <kasong@tencent.com>
> 
> The workflow example code is not working since it got the file names
> wrong. So fix this.

Nice finding, thank you for this patch!

> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  Documentation/admin-guide/mm/damon/usage.rst | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> index d52f572a90298..ca91ecc290785 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
> @@ -50,10 +50,10 @@ For a short example, users can monitor the virtual address space of a given
>  workload as below. ::
>  
>      # cd /sys/kernel/mm/damon/admin/
> -    # echo 1 > kdamonds/nr && echo 1 > kdamonds/0/contexts/nr
> +    # echo 1 > kdamonds/nr_kdamonds && echo 1 > kdamonds/0/contexts/nr_contexts
>      # echo vaddr > kdamonds/0/contexts/0/operations
> -    # echo 1 > kdamonds/0/contexts/0/targets/nr
> -    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid
> +    # echo 1 > kdamonds/0/contexts/0/targets/nr_targets
> +    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid_target
>      # echo on > kdamonds/0/state
>  
>  Files Hierarchy
> @@ -366,12 +366,12 @@ memory rate becomes larger than 60%, or lower than 30%". ::
>      # echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
>      # cd kdamonds/0/contexts/0/schemes/0
>      # # set the basic access pattern and the action
> -    # echo 4096 > access_patterns/sz/min
> -    # echo 8192 > access_patterns/sz/max
> -    # echo 0 > access_patterns/nr_accesses/min
> -    # echo 5 > access_patterns/nr_accesses/max
> -    # echo 10 > access_patterns/age/min
> -    # echo 20 > access_patterns/age/max
> +    # echo 4096 > access_pattern/sz/min
> +    # echo 8192 > access_pattern/sz/max
> +    # echo 0 > access_pattern/nr_accesses/min
> +    # echo 5 > access_pattern/nr_accesses/max
> +    # echo 10 > access_pattern/age/min
> +    # echo 20 > access_pattern/age/max
>      # echo pageout > action
>      # # set quotas
>      # echo 10 > quotas/ms
> -- 
> 2.35.2
> 
