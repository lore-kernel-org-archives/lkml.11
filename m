Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E21C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 03:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbiDADOY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 23:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiDADOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:14:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243F0249C60;
        Thu, 31 Mar 2022 20:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD228B82206;
        Fri,  1 Apr 2022 03:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B2FC2BBE4;
        Fri,  1 Apr 2022 03:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648782751;
        bh=Ni1gEgCkEx6pOktzvdKqc6Byl27/qXvDpW/HGefjY0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uzsj3kbnzRZThMm7e7ZhPxgt3mzzCSQu5wdt5CzF/bEf4dtx+k1WgsPmY842SHqv4
         o82KyJzCRphH7vhxgu8+9zTWKiWIIfRL6qZgtpzgn/WNqZ8KCDGH5pHySIr17T30eo
         Px5H4ayLdMn65VcFfltcOxlPF6M+i1n+e/LDyV7vIBf2qKeQYuMibzcuhVF/+wt1OE
         7gHwUwhqYldjo1gL5zwyNO613OScgDfHAMQwqXCf4qEq+o1YaF42nuDFGxlTqwttpu
         +hfdKXPO5Cx25SIImWHzQjsqd5NDdNCRFVekJ+MKb/wJbRgKXsJZv1uSvba01DXB2l
         7LQEsmJmSt83g==
Date:   Thu, 31 Mar 2022 20:12:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     jackygam2001 <jacky_gam_2001@163.com>
Cc:     dkirjanov@suse.de, edumazet@google.com, davem@davemloft.net,
        pabeni@redhat.com, rostedt@goodmis.org, mingo@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yhs@fb.com,
        ping.gan@dell.com
Subject: Re: [PATCH v2 net-next] tcp: Add tracepoint for tcp_set_ca_state
Message-ID: <20220331201229.1cbd4f0b@kernel.org>
In-Reply-To: <20220331082149.15910-1-jacky_gam_2001@163.com>
References: <9f7a92f5-5674-5c9f-e5ec-4a68ec8cb0d1@suse.de>
        <20220331082149.15910-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 16:21:49 +0800 jackygam2001 wrote:
> From: Ping Gan <jacky_gam_2001@163.com>
> 
> The congestion status of a tcp flow may be updated since there
> is congestion between tcp sender and receiver. It makes sense to
> add tracepoint for congestion status set function to summate cc
> status duration and evaluate the performance of network
> and congestion algorithm. The backgound of this patch is below.
> 
> Link: https://github.com/iovisor/bcc/pull/3899
> 
> Signed-off-by: Ping Gan <jacky_gam_2001@163.com>

# Form letter - net-next is closed

We have already sent the networking pull request for 5.18
and therefore net-next is closed for new drivers, features,
code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after 5.18-rc1 is cut.

RFC patches sent for review only are obviously welcome at any time.
