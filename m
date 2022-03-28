Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30458C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 22:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiC1Wv4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiC1Wvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C8238181;
        Mon, 28 Mar 2022 15:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08FBD60C27;
        Mon, 28 Mar 2022 22:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06188C340EC;
        Mon, 28 Mar 2022 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648507812;
        bh=XFHKrVCMGFjxm/UZYRGZkUrae/PoudT6XXiFP4MNXDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dPW+S++mOMomZgR1mhPuuXyAs33LJ1rc+GNMVt3EdPDE5oMPoSCAUOCmqkfs7n9+Z
         4HNEt2ImEzIBaBCUnIQj3RdP/IMnYOi750x4T3g9NQVL/21re4sCybP2zvJct8yNce
         eVdujFKLGXwnoPitthreD19Tu+Dbr3st61SgUKVWfNxXNF63iAEydmvZ6cReHQ/0er
         loFnzhPCJ/yspMIoiVpXJDcV8e+McGCO07O4BW3z5zgwdhmeW3Z8KlHTGbYayOd8T0
         N8lWhZG5wSMWg1xjmyE2lQgXqJm27hUgjEU2Srs6pNa67uOuAXVbOVAifFUIdir3cw
         da0svqeL1Ibdw==
Date:   Mon, 28 Mar 2022 15:50:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andrew Melnychenko <andrew@daynix.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, davem@davemloft.net,
        jasowang@redhat.com, mst@redhat.com, yan@daynix.com,
        yuri.benditovich@daynix.com
Subject: Re: [PATCH v5 0/4] RSS support for VirtioNet.
Message-ID: <20220328155010.620849e5@kernel.org>
In-Reply-To: <20220328175336.10802-1-andrew@daynix.com>
References: <20220328175336.10802-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 20:53:32 +0300 Andrew Melnychenko wrote:
> Virtio-net supports "hardware" RSS with toeplitz key.
> Also, it allows receiving calculated hash in vheader
> that may be used with RPS.
> Added ethtools callbacks to manipulate RSS.
> 
> Technically hash calculation may be set only for
> SRC+DST and SRC+DST+PORTSRC+PORTDST hashflows.
> The completely disabling hash calculation for TCP or UDP
> would disable hash calculation for IP.
> 
> RSS/RXHASH is disabled by default.

# Form letter - net-next is closed

We have already sent the networking pull request for 5.18
and therefore net-next is closed for new drivers, features,
code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after 5.18-rc1 is cut.

RFC patches sent for review only are obviously welcome at any time.
