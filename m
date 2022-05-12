Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC4EC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 17:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356802AbiELREQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242193AbiELREO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:04:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57016D4DA;
        Thu, 12 May 2022 10:04:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7EEC71F8EF;
        Thu, 12 May 2022 17:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652375052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8x6aPJt6yqRe+xxwaduylXqRn+TAS3mKV8QmNRMu74M=;
        b=oqAeYgjoS/Yzrg0FlOaRvqUONZMeshLiVKHa5kE0tg7n3W/Qd8TjfD2+9mXN1PtCJP58R8
        wnlHvNSmzK+5ejL8Fn0anZd7UdrYBDHqSDVzVTUq6+y9ZXzNhqW3be11YgM8I/tx3NwAfM
        R0sJIrUtOa7NJDVEeM6pKGJS33DF4rc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 453DB13ABE;
        Thu, 12 May 2022 17:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0BnrDww+fWIuHAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 12 May 2022 17:04:12 +0000
Date:   Thu, 12 May 2022 19:04:10 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     David Vernet <void@manifault.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH v2 0/5] Fix bugs in memcontroller cgroup tests
Message-ID: <20220512170410.GA16096@blackbody.suse.cz>
References: <20220423155619.3669555-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423155619.3669555-1-void@manifault.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Sat, Apr 23, 2022 at 08:56:15AM -0700, David Vernet <void@manifault.com> wrote:
> tools/testing/selftests/cgroup/test_memcontrol.c contains a set of
> testcases which validate expected behavior of the cgroup memory controller.
> Roman Gushchin recently sent out a patchset that fixed a few issues in the
> test.

Link here
https://lore.kernel.org/r/20220415000133.3955987-1-roman.gushchin@linux.dev/.

> This patchset continues that effort by fixing a few more issues that
> were causing non-deterministic failures in the suite.

Are the Roman's patches merged anywhere? (I ran into some issues when I
was rebasing your (David's) series on top of master.) I'd like to put
all sensible patches in one series or stack on existing branch (if
there's any).

For possible v3 of this series, I did:
  - dropped the patch that allows non-zero memory.events:low for a sibling with
    memory.low=0 when mounted with memory_recursiveprot (the case needs more
    discussion),
  - added few more cleanups, convenience for debugging,
  - fixed comments in the first patch.

Pushed here [1] before properly sending the v3 for discussion.

Thanks,
Michal

[1] https://github.com/Werkov/linux/commits/cgroup-ml/memory.low-overreclaim-var2

