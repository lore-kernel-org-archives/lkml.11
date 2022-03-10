Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E177C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 01:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbiCJBul (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiCJBuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:50:39 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332441275EB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:49:40 -0800 (PST)
Date:   Wed, 9 Mar 2022 17:49:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646876978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KWBNdn64wpDGZBAntprlV8MUAyPFqkJHbbFkUKlSd/0=;
        b=hG3q0xyluhiPWTbMKaV4+3rkV3TUXrhYSLAjdNS9MoSjY7sYVFMw8x/hDpBq9CfM6uZcz5
        +yyv7sZmOguyaVnPp1jvsNO8I/bySHhC3ttEhxU+Aqn04zvskZjjLDq3ymIXFv2ZtObHfF
        gnDAISN0KYG8IfFTQ/o6KIumI0fRuN8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     sxwjean@me.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        longman@redhat.com, guro@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH 1/2] mm: slab: Delete unused SLAB_DEACTIVATED flag
Message-ID: <YilZK/SUs9cnZTrt@carbon.dhcp.thefacebook.com>
References: <20220309145052.219138-1-sxwjean@me.com>
 <20220309145052.219138-2-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309145052.219138-2-sxwjean@me.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:50:51PM +0800, sxwjean@me.com wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> Since commit 9855609bde03 ("mm: memcg/slab: use a single set of
> kmem_caches for all accounted allocations") deletes all SLAB_DEACTIVATED
> users, therefore this flag is not needed any more, let's delete it.

Indeed! Thank!

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
