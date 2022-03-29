Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395C4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 02:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiC2CWt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 22:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiC2CWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2649243144;
        Mon, 28 Mar 2022 19:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C31661287;
        Tue, 29 Mar 2022 02:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18222C340EC;
        Tue, 29 Mar 2022 02:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648520464;
        bh=HKtkQksT8pneWdeXaLVwESB0pNlyHOGRqkTcQiY+g0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PJzOqvrDu60jUZsGYcWpApGltLUMYc1ETr/LrdPrBQkVqSTRlM3RXnHqIYtghy84G
         9wcL0lLhKGQ6+4sJFniMqdQgoffHmASoVqLzjh9zIa7R23E8eczEJ0hkGPv+hCc9bG
         iE6vdyrzk1aa0DXp5OutbSYKOaGO94bYZo0uML7WmgJeHaXgIoKVkuhuDomNgYgFWw
         d5Ilh9c58JykNAAjr0KBv94/9gsSa/wAd8yzmWBdXhrVfhD6sa8RHOzEgMYwHA20WT
         GkA0+kVfMDoGqF3oVKL9I3f2R5A4vmQ7MmY4BdkxchSRXi/FLvpqvVGCYhO8Pt2HID
         G28ZhpeSe7Iug==
Date:   Mon, 28 Mar 2022 19:21:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     dsahern@kernel.org, pabeni@redhat.com, rostedt@goodmis.org,
        mingo@redhat.com, xeb@mail.ru, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, imagedong@tencent.com,
        edumazet@google.com, kafai@fb.com, talalahmad@google.com,
        keescook@chromium.org, alobakin@pm.me, flyingpeng@tencent.com,
        mengensun@tencent.com, dongli.zhang@oracle.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        benbjiang@tencent.com
Subject: Re: [PATCH net-next v5 0/4] net: icmp: add skb drop reasons to icmp
Message-ID: <20220328192103.4df73760@kernel.org>
In-Reply-To: <20220328042737.118812-1-imagedong@tencent.com>
References: <20220328042737.118812-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 12:27:33 +0800 menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> In the commit c504e5c2f964 ("net: skb: introduce kfree_skb_reason()"),
> we added the support of reporting the reasons of skb drops to kfree_skb
> tracepoint. And in this series patches, reasons for skb drops are added
> to ICMP protocol.

# Form letter - net-next is closed

We have already sent the networking pull request for 5.18
and therefore net-next is closed for new drivers, features,
code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after 5.18-rc1 is cut.

RFC patches sent for review only are obviously welcome at any time.
