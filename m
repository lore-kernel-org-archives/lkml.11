Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D6C19F2D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 07:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiHKH2X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 03:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiHKH2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:28:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D86923D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:28:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D223768AA6; Thu, 11 Aug 2022 09:28:17 +0200 (CEST)
Date:   Thu, 11 Aug 2022 09:28:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <20220811072817.GB13886@lst.de>
References: <20220325122559.14251-1-mhocko@kernel.org> <Yj28gjonUa9+0yae@dhcp22.suse.cz> <20220325164856.GA16800@lst.de> <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz> <YupFSpXOrcfXJNya@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YupFSpXOrcfXJNya@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 11:52:10AM +0200, Michal Hocko wrote:
> OK, so I have another machine spewing this warning. Still on an older
> kernel but I do not think the current upstream would be any different in
> that regards. This time the DMA zone is populated and consumed from
> large part and the pool size request is just too large for it:

I can't really parse the last sentence.  What does "consumed from large
part" mean here?
