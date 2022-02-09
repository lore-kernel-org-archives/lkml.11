Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740F8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 16:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiBIQDa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 11:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbiBIQD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:03:26 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDAEC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:03:30 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id o25so1971284qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=038Kq4HxYFM+fA4AaZi4fyE5bdjjt0bTEZgQgtvXcxo=;
        b=abEhuyEoXj5fzKmch4cBB4p3U6tsw6pjAuCUQYzYkQ4U/RdCJVAXg6H3jCOjXD+6h0
         mdayPkSRqrhmkOg54UpFoWXpXkxc8f55dlaV1DgPoEEhH9z8oBDdJXeyOoi66+QAkMGI
         AX/99n+lZ6nYtC9WKiFmeqvnxVPBuG6xgyq667hYGdVlT3URrW/AMlMc/Vvdeb+j4QFX
         S6Zggl1gO5lINVk1SqgS9uUPfP+VMXj47O3Zkikw8LUFptMbIjlpGzVWCLnwPpFxSfm2
         94e67x1TsADR5GSl2mfbsZhRvuW7fSGtVdXeeimB+F7jChUg3NuubDS+qgkJbcucnyZt
         7iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=038Kq4HxYFM+fA4AaZi4fyE5bdjjt0bTEZgQgtvXcxo=;
        b=T142dqg8pB/t+eFuchsqf2c4dBfZozq4ZMH/emrs9ozHzf9UCYb/gEDA/4ATz++anR
         /K05UBluos8/rJezmAt6KI+CmpO1ZDqjLLcKa71oMjUtYxF8Nf4zYwSW+b30Qb4INgyF
         IBD6UlMW//anYmSFP3yAizdvQ/iYgfvP4EYPsZcHv1E1pbplTkpTj0+hQdiLfTvRTlPp
         0CsYNrQwgwK/DO58U5mN6y7obG0TPhFrcetBJh8ZwSTvJi3HbLjxkngQ1CNF1QUzf/eI
         Dh4zJDkc/KkHpK/NfX/V8GOkQsN0+I9deifTUrjZnFfPHiTPOuBtJnjjmHzO/5qeXmrW
         4hKg==
X-Gm-Message-State: AOAM531r7bnSucqRlMDqTq+ofYyY8Q2nchkCJ95LVXi/f0saQd6XQFkd
        ccCkkcSeLTUqfOqpMCQhItEWCQ==
X-Google-Smtp-Source: ABdhPJx2JVEbpZB2x+O1x3TuEv2vgIEl5U5HQXJalRC5/IJOEZUcM0zOngvhe9acRuJ6uEJQCjhLZg==
X-Received: by 2002:a05:620a:22d4:: with SMTP id o20mr1514481qki.90.1644422609083;
        Wed, 09 Feb 2022 08:03:29 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o1sm9318353qkp.49.2022.02.09.08.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:03:28 -0800 (PST)
Date:   Wed, 9 Feb 2022 08:03:26 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the akpm-current
 tree
In-Reply-To: <20220209170245.08968c92@canb.auug.org.au>
Message-ID: <d2701072-99e6-762b-bc80-64bda193c792@google.com>
References: <20220209170245.08968c92@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the akpm-current tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> include/linux/mm_types.h:272: warning: Function parameter or member '__filler' not described in 'folio'
> include/linux/mm_types.h:272: warning: Function parameter or member 'mlock_count' not described in 'folio'
> 
> Introduced by commit
> 
>   60a5c5ab0ba7 ("mm/munlock: maintain page->mlock_count while unevictable")

Thank you for including the patches and reporting this, Stephen.
Is this a warning you can live with for a week or two?

I've never tried generating htmldocs (I'm tempted just to replace a few
"/**"s by "/*"s!), and I'm fairly sure Matthew will have strong feelings
about how this new union (or not) will be better foliated - me messing
around with doc output here is unlikely to be helpful at this moment.

Hugh
