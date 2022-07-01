Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D68C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 16:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiGAQUl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 12:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiGAQUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:20:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B33CA40;
        Fri,  1 Jul 2022 09:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48FB3B82DDC;
        Fri,  1 Jul 2022 16:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6204DC3411E;
        Fri,  1 Jul 2022 16:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656692436;
        bh=Z2xafc+cegZK1vCDd3H5jyiD+6RayuMGctBfk1iL9qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCvCjVFbrOJ/ObN8Wou9blCYrrEl4ShOftr+VTqUSp8dHl8aCN3XlwX7flIoOrVBR
         BV69xswKIklotjygdry4FgGeVWO9psnGEyKscunSh2XdwuTQWC1MkWeI+0RcVqhig9
         4/bsKRwDF1G2fNmKgV3JRaPGTgefO3eWZpnJ8+4VdwgkcCxjBbWOfxnbHNqevAAtuC
         GdTosdBQhLyIlcie06jSXnqkcJVFNLMl1xUcnTiwL1S1hNtuL2ScW5mJV6nYMw+Fre
         gX5bfIgPpO249/1KNnnB9NLWEorhDf946i/zkS9OZ9mxW7Arl0WlUoX4soSnO/nzHn
         NZKbhMjbq0HGg==
Date:   Fri, 1 Jul 2022 21:50:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ep93xx: Fix typo in comments
Message-ID: <Yr8ezq3hGjq2+S+S@matsya>
References: <20220622143158.15091-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622143158.15091-1-jiangjian@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-22, 22:31, Jiang Jian wrote:
> Remove the repeated word 'and' from comments

Applied, thanks

-- 
~Vinod
