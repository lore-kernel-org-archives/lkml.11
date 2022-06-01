Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B224BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 17:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356219AbiFARBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiFARBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A38313B1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2EF0614AB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 17:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1100C385B8;
        Wed,  1 Jun 2022 17:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654102880;
        bh=DjugIgjMpnLg2sPBAyVxP39aECuON049MwOKV8GD/bY=;
        h=Date:From:To:Cc:Subject:From;
        b=UmMIsjoydp/DWM+rFLQIuL6vrWZFbRyhSN0liZ9qDgnSMo3elq5ZpczKUlwrvd9f7
         slJWRA4AEhiohX/gQjucXYUsSgRRh1pN3bZRsz2SerbNg+V3PxZy0IfY7QRKp64RQC
         xRt643mCy4ZNZ8/qa8Tf4faVIgChe7+tq0BgUb/oE1/FfwGQyoUQTSTCGnuDIqK1IG
         1FNdbiBjKwfOqnKLM+BrKCTN66b/4wlfIK8rhhwyrqaFIf474lpDBTXtgUG5gsDzEI
         5+RjcrfB+eFrev1pkGaz8GsM+ebWMul1vfpydoEnenZIoUwDAoBVyjZvoQ+udqcDyr
         Vvc4N2wxdbevw==
Date:   Thu, 2 Jun 2022 01:01:11 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs fixes for 5.19-rc1
Message-ID: <YpebV0BiGsrl8UDQ@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a follow-up pull request including some fixes of fscache
mode related to compressed inodes and a cachefiles tracepoint.
There is also a patch to fix an unexpected decompression strategy
change due to a cleanup in the past.  All the fixes are quite small.

Apart from these, documentation is also updated for a better
description of recent new features.

In addition, the reason why I decided to post these now is that
I'm working on folio adaption for compressed files with widely
cleanups.  It seems that some trivial cleanups without actual logical
change can be submitted in advance, so I could have a more recent
codebase to work on folios and avoiding the PG_error page flag for
the next cycle.  It'd be better to submit them in this merge window
instead of post-rc1 since they are not fixes strictly.

All commits have been in -next and stress tested.
Please consider this request!

Thanks,
Gao Xiang

The following changes since commit 65965d9530b0c320759cd18a9a5975fb2e098462:

  Merge tag 'erofs-for-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs (2022-05-24 18:42:04 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.19-rc1-fixes

for you to fetch changes up to 4398d3c31b582db0d640b23434bf344a6c8df57c:

  erofs: fix 'backmost' member of z_erofs_decompress_frontend (2022-05-31 23:15:30 +0800)

----------------------------------------------------------------
Changes since last update:

 - Leave compressed inodes unsupported in fscache mode for now;

 - Avoid crash when using tracepoint cachefiles_prep_read;

 - Fix `backmost' behavior due to a recent cleanup;

 - Update documentation for better description of recent new features;

 - Several decompression cleanups w/o logical change.

----------------------------------------------------------------
Gao Xiang (4):
      erofs: update documentation
      erofs: get rid of `struct z_erofs_collection'
      erofs: get rid of label `restart_now'
      erofs: simplify z_erofs_pcluster_readmore()

Jeffle Xu (1):
      erofs: leave compressed inodes unsupported in fscache mode for now

Weizhao Ouyang (1):
      erofs: fix 'backmost' member of z_erofs_decompress_frontend

Xin Yin (1):
      erofs: fix crash when enable tracepoint cachefiles_prep_read

 Documentation/filesystems/erofs.rst |  64 +++++++++-----
 fs/erofs/fscache.c                  |   1 +
 fs/erofs/inode.c                    |   5 +-
 fs/erofs/zdata.c                    | 167 +++++++++++++++---------------------
 fs/erofs/zdata.h                    |  50 +++++------
 5 files changed, 136 insertions(+), 151 deletions(-)

