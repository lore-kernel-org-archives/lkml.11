Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FFBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 17:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349630AbiFJRhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 13:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346385AbiFJRhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:37:42 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7515B2253A;
        Fri, 10 Jun 2022 10:37:40 -0700 (PDT)
Date:   Fri, 10 Jun 2022 10:37:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654882657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aW3oaiQ+4odp/b7PhaytgoSviL5XCuOau8LFuv+aRFw=;
        b=tfxeRe6MRRljjmzvu6H+5ccy7o8+YUIloW5Ey8NpwSki9JAACaOaJEgGeMw36HeV7S1XYQ
        Lb5P3JsCocwOZrIXDn5ufV+wGyy9kGeAlQg9UiDzVXdJEpGsU0FOl/DD7O9humY2omf1xv
        BVCuhuc6tYJIpZf78r3zCXjNKvDqHwg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     cgel.zte@gmail.com
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm: memcontrol: reference to
 tools/cgroup/memcg_slabinfo.py
Message-ID: <YqOBVu+lYIFJOzc+@carbon>
References: <20220610024451.744135-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610024451.744135-1-yang.yang29@zte.com.cn>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 02:44:52AM +0000, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> There is no slabinfo.py in tools/cgroup, but has memcg_slabinfo.py instead.
> 
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
