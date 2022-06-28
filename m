Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E63C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 04:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbiF1E5S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 00:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiF1E5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:57:15 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2113560D5;
        Mon, 27 Jun 2022 21:57:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B2D718106;
        Tue, 28 Jun 2022 04:52:01 +0000 (UTC)
Date:   Tue, 28 Jun 2022 07:57:12 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Liang He <windhl@126.com>
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/mach-omap2: Fix refcount leak bug in omap_hwmod.c
Message-ID: <YrqKKBflkZKRHwXW@atomide.com>
References: <20220618014747.4055279-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618014747.4055279-1-windhl@126.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Liang He <windhl@126.com> [220618 04:43]:
> In _init(), of_find_node_by_name() will return a node pointer with
> refcount incremented. We should use of_node_put() in fail path or
> when it is not used anymore.
> 
> NOTE: As the ref will be passed from 'bus' to 'np' by the xx_lookup(),
> in normal exit path, we should call of_node_put() at the end use of 'np',
> not the end use of 'bus'.

Looks correct to me. What about missing of_node_put() for
of_get_next_child() also in the _init() function?

Regards,

Tony
