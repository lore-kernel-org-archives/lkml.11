Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470BAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 10:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383050AbiEBKDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 06:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384706AbiEBJ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:59:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950B34A3DA
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 02:53:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E57751F8AB;
        Mon,  2 May 2022 09:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651485203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YtO7nfzlefXiRENj/ugjHQpqg0xyePTCQXyxKhRQBRU=;
        b=i9QB+6VMM8y1aM5RRHjv8Yy4uhYwv/EAcLyuoBPoe1Ldvsxb3M74y1ffpr00MTa3Wy41fE
        3jMo19xrDehbPvmVbRRc9pRmUVsmC0568Nvw9a0+4VNPbF/33qZltmtlTvJOIPuM+orLiF
        6tl9ukzGTwv4dUxtJVsNuSBcjdXx22I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651485203;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YtO7nfzlefXiRENj/ugjHQpqg0xyePTCQXyxKhRQBRU=;
        b=9RYJ47aH3zDMBae3MhAZ7npe5RF5XxtRL2tDT1utv8sFQnvgpeTR02ZZhhgZnvzWKmV7Qd
        7/Yef710mWpmbeDQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0B3312C141;
        Mon,  2 May 2022 09:53:23 +0000 (UTC)
Date:   Mon, 2 May 2022 10:53:21 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: cache the result of node_dirty_ok()
Message-ID: <20220502095321.GA20579@suse.de>
References: <20220430011032.64071-1-vvghjk1234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220430011032.64071-1-vvghjk1234@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 10:10:32AM +0900, Wonhyuk Yang wrote:
> To spread dirty page, nodes are checked whether
> it reached the dirty limit using the expensive
> node_dirty_ok(). To reduce the number of calling
> node_dirty_ok(), last node that hit the dirty
> limit is cached.
> 
> Instead of caching the node, caching both node
> and it's result of node_dirty_ok() can reduce
> the number of calling node_dirty_ok() more than
> before.
> 
> Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>

Acked-by: Mel Gorman <mgorman@suse.de>

I agree with Andrew that last_pgdat_dirty_ok is a better name. The old
name was also bad but seeing as the area is being changed, fixing the
name is harmless.

-- 
Mel Gorman
SUSE Labs
