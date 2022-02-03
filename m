Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1291EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Feb 2022 14:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244810AbiBCOzx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351564AbiBCOzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:55:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A17C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 06:55:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 247B761A78
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 14:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522D0C340E4;
        Thu,  3 Feb 2022 14:55:36 +0000 (UTC)
Date:   Thu, 3 Feb 2022 14:55:32 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Lang Yu <lang.yu@amd.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/kmemleak: Avoid scanning potential huge holes
Message-ID: <Yfvs5OVKDyWv9HLo@arm.com>
References: <20211108140029.721144-1-lang.yu@amd.com>
 <YfREFu1sAJ+Yn6jy@arm.com>
 <20220131165141.0554c6017455c64cb1391dca@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131165141.0554c6017455c64cb1391dca@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 04:51:41PM -0800, Andrew Morton wrote:
> On Fri, 28 Jan 2022 19:29:26 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Thanks.
> 
> I think this deserves a cc:stable?  Triggering the soft lockup detector
> is bad behavior.

Yes, I think it should. I guess the problem is not widely spread as
no-one reported it until recently.

-- 
Catalin
