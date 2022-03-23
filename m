Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D8CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 17:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245601AbiCWRB6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 13:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbiCWRB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:01:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CF078907
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E616EB81F84
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746BAC340E8;
        Wed, 23 Mar 2022 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648054823;
        bh=YAquSOcRUC+gYTS9VpyVU22HjPExypfghULoDcZfSf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZ9BRlBYbOHGBfM59Egi3Xf3r07BBeufdqhF6ZXakOodWBx8No7zKF6ajnXpXPb+G
         GhBbtiLY7sn4IL33+sUM9AOZQ6GZHbEXiT/24pZqqDd2VUycbVb0zeNB79y5QNMpZ1
         ZZd7pzNoFkkOPAT979o8svtxXwi7SweVyMmhl58q1X8FQFYXbH+AvDcuZQfjMICD6z
         GbbPCr+CeXO9ygj+sJgvdMtGt8Lt9xr0cIg1kvwducCXHjfL1r3rxmKc4SuUlJvcd5
         Ra3yFlyVBsxatVObHU2M2cLwjpLZvYbVJ0F0lsM/4aDVgyjSFoYXSl5/5vnqmratmF
         SZLJ71lhhbfTw==
Date:   Wed, 23 Mar 2022 10:00:21 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] f2fs for 5.18
Message-ID: <YjtSJaG6KQ3zvzUs@google.com>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <YjrNRpbo/i3tgbAA@infradead.org>
 <YjtPUec8jiqUXGuf@google.com>
 <YjtPq1V7hbxc93aj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjtPq1V7hbxc93aj@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Christoph Hellwig wrote:
> On Wed, Mar 23, 2022 at 09:48:17AM -0700, Jaegeuk Kim wrote:
> > Christoph, I proposed,
> > 
> > "I've been waiting for a generic solution as suggested here. Until then, I'd like
> > to keep this in f2fs *only* in order to ship the fix in products. Once there's
> > a right fix, let me drop or revise this patch again."
> > 
> > https://lore.kernel.org/linux-f2fs-devel/YhZzV11+BlgI1PBd@google.com/
> 
> That counts as ignoring the advice to me.

My apologies that you felt like that. Thanks,
