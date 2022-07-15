Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93892CCA47B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 01:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiGOBjP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 21:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiGOBjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:39:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874AA3192C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:39:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31c9d560435so29515027b3.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mAeXqOZZBVPdbq4yhQiUP5VN0GJajqrt77b0GTm8ddQ=;
        b=JfY/dZhiys1bZY5EGSfSj6NS3oNMqRabw0VWDSE9yIeZMDLkSZqc+2FvMnzpS4MNgZ
         XOFzz5TtApvGzeW/vTh65Ag9cCAWr3OBzN4gAv4CDkN+voEmvI9EdsHqA7vo7vvm4OyG
         kgPnXqIerO7mSCxfm6ZLl7CSkBrXFSl32yXeRbVtior4ZdkP6BQJmSFZqNdYcm3LxDyl
         j9UFszpl2EpD+Pge2UyrwQcfprrMB0rwLkicdT4Eeak3RDQO1ugIpwyxBjErKRLN+CEp
         XJMbd3u4sWaJP27ptJxp7gFOIRpGqWZVCj56XMU8IayCbz29K0X7EcS9njUklygLxjva
         DvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mAeXqOZZBVPdbq4yhQiUP5VN0GJajqrt77b0GTm8ddQ=;
        b=w9/LqNTio7LLUUXTDhgW7LCOWg6npbtLgki5gHaSDF+qaKK3o+2u4YoMZKzQ4LRmJm
         TRECbLIYtSBTXnTzrgY60gcM+uzChBWCHNkJ4GFT5PiaRZYh9SbI1oHE7PiKeEtWePZM
         yqf4hjAcfg8RTM/768bM4y7ywvzykGKfzOeVTxE77aSfGAjWgR8yapWH4pDm/5lPcH9q
         m6JpU5ss+XNAW4WVU5MzOw8sl6zO9MV8pV6BVIzEfjsXzevkpR0cUObjqtybu7eigF9R
         +ot5wiaIZYZzSI4bAlZL6updu29g2qcipJO0PdbROvDYmOvXIUdaCsDYuxB6A+PhE1C0
         Yf0A==
X-Gm-Message-State: AJIora9P0Q0a6IHXZFWbrO7MzAaSzlxxda13bQv6ZCGOwzkz1HUet95k
        1bnUS7NJu7UGiDfKc2HV5b1z7GZVNlX+5g==
X-Google-Smtp-Source: AGRyM1twMADmukVDHq0OwkYLBQBbC2d2LlX8VOPaRlImf1uqHpMX5qVQPJ25TQtBfNyXY015rkJIjGLC0J2OxQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:a2ca:0:b0:66e:719e:279 with SMTP id
 c10-20020a25a2ca000000b0066e719e0279mr11067587ybn.622.1657849150783; Thu, 14
 Jul 2022 18:39:10 -0700 (PDT)
Date:   Fri, 15 Jul 2022 01:39:08 +0000
In-Reply-To: <534fa596-0c29-0f1e-b292-53ad9c3dbbe3@I-love.SAKURA.ne.jp>
Message-Id: <20220715013908.ayyimue5yhfwonho@google.com>
Mime-Version: 1.0
References: <000000000000471c2905e3c2c2c2@google.com> <20220714141813.yi5p4o2tiyvkao6b@quack3>
 <534fa596-0c29-0f1e-b292-53ad9c3dbbe3@I-love.SAKURA.ne.jp>
Subject: Re: [syzbot] possible deadlock in start_this_handle (3)
From:   Shakeel Butt <shakeelb@google.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 07:24:55AM +0900, Tetsuo Handa wrote:
> On 2022/07/14 23:18, Jan Kara wrote:
> > Hello,
> > 
> > so this lockdep report looks real but is more related to OOM handling than
> > to ext4 as such. The immediate problem I can see is that
> > mem_cgroup_print_oom_meminfo() which is called under oom_lock calls
> > memory_stat_format() which does GFP_KERNEL allocations to allocate buffers
> > for dumping of MM statistics. This creates oom_lock -> fs reclaim
> > dependency and because OOM can be hit (and thus oom_lock acquired) in
> > practically any allocation (regardless of GFP_NOFS) this has a potential of
> > creating real deadlock cycles.
> > 
> > So should mem_cgroup_print_oom_meminfo() be using
> > memalloc_nofs_save/restore() to avoid such deadlocks? Or perhaps someone
> > sees another solution? Generally allocating memory to report OOM looks a
> > bit dangerous to me ;).

mem_cgroup_print_oom_meminfo() is called only for memcg OOMs. So, the
situaion would be dangerous only if the system is also OOM at that time.

> > 
> > 								Honza
> 
> I think mem_cgroup_print_oom_meminfo() should use GFP_ATOMIC, for it will fall into
> infinite loop if kmalloc(GFP_NOFS) under oom_lock reached __alloc_pages_may_oom() path.

I would prefer GFP_NOWAIT. This is printing info for memcg OOMs and if
the system is low on memory then memcg OOMs has lower importance than
the system state.
