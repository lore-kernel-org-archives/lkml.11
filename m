Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86DFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 17:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiGORyv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGORyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:54:47 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D7E33375;
        Fri, 15 Jul 2022 10:54:46 -0700 (PDT)
Date:   Fri, 15 Jul 2022 10:54:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657907684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6uT+2TT9W95VXeCHWDiSSD2luBuxQhau1FLF5w4a/0c=;
        b=MZyZiEOxH6F+9U95uSCMXEsHLFlHo3bfeOfGDlmL7fIJyMrAy0ahKSFopt1ppvQMgec/PO
        HZaTUvdsJ4GHoFKSl5kWqwYBQIf9EfeDYAQ3ieyja5nsH97q6pAEK9LYHuASLS0u6C0JpU
        JQEWtQRluVwP2j2cDeHhcbonQDaPZvE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     axboe@kernel.dk, asml.silence@gmail.com, fam.zheng@bytedance.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        usama.arif@bytedance.com
Subject: Re: [PATCH] io_uring: Don't require reinitable percpu_ref
Message-ID: <YtGp318DAmjXrHh3@castle>
References: <8a9adb78-d9bb-a511-e4c1-c94cca392c9b@kernel.dk>
 <20220715174501.25216-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220715174501.25216-1-mkoutny@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 07:45:01PM +0200, Michal Koutny wrote:
> The commit 8bb649ee1da3 ("io_uring: remove ring quiesce for
> io_uring_register") removed the worklow relying on reinit/resurrection
> of the percpu_ref, hence, initialization with that requested is a relic.
> 
> This is based on code review, this causes no real bug (and theoretically
> can't). Technically it's a revert of commit 214828962dea ("io_uring:
> initialize percpu refcounters using PERCU_REF_ALLOW_REINIT") but since
> the flag omission is now justified, I'm not making this a revert.
> 
> Fixes: 8bb649ee1da3 ("io_uring: remove ring quiesce for io_uring_register")
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
