Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E51C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 02:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbiEYCnN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 22:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbiEYCnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:43:11 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66DD6FD34;
        Tue, 24 May 2022 19:43:10 -0700 (PDT)
Date:   Tue, 24 May 2022 19:43:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653446588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IzX85D9y8VZc2IadwWQIPquJuvjI/THj3QAzh+7YEVk=;
        b=pY4AWZ78/UZn4TWf6HOYv4Shw6u6k6wcAApxRzoORivOvLOkoMivA3GRfykLZzPgLh8DwO
        SmjLNsvpvdP7jyPL3PYNt023IaGaHGc6ax0hkxQc26RMILhroY9sglbhEINVzQae2V70Sm
        bInt/T6+8/yddwoRi0/SL0OHagyEE1A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 04/11] mm: vmscan: rework move_pages_to_lru()
Message-ID: <Yo2Xt6zFxNrf9M5j@carbon>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524060551.80037-5-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 02:05:44PM +0800, Muchun Song wrote:
> In the later patch, we will reparent the LRU pages. The pages moved to
> appropriate LRU list can be reparented during the process of the
> move_pages_to_lru(). So holding a lruvec lock by the caller is wrong, we
> should use the more general interface of folio_lruvec_relock_irq() to
> acquire the correct lruvec lock.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

With changes asked by Johannes :

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
