Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B74AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 20:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiFHUFX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiFHUFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:05:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E7A3739D5;
        Wed,  8 Jun 2022 13:05:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9144B82AC5;
        Wed,  8 Jun 2022 20:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EFBC34116;
        Wed,  8 Jun 2022 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654718713;
        bh=SmytPEfGwBJ2p4P4d8BkY6Gajja96/lzIIJ+b8ClZgc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EZhzoDUL1ou7c1kgkzGA03/5hnRlARoPR/j3SJLptnmJqUrISXbZ4YVs/S3Cw67ZV
         AOGdtDZ6hdtTjyeW4Tlqtvnxn7ZtKweY1SJkNnifHCLlTGUO8dBPa2a4uAk1cb1Pes
         ajOu4wJ1X7GesN3BHlNVDViW55EKQ3DeyTx2NAd/SMU4ysCMql7UZN3154RbQ/RE1D
         /oR+JGoRfc3CZH6ROnKuizVikYKty2sGu8HbAtDQ1Mq5JJ2Ifi4qVAgGKhvYJF3jlM
         Q6UNMcUU2iecUb5azON5me7LL1FefYvkE+U/wgGGqRAr+DIbC0jTyibC7LGpqLx1X/
         1I8Fe6VLaWiEQ==
Date:   Wed, 8 Jun 2022 13:05:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     syzbot <syzbot+a7c030a05218db921de5@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, erdnetdev@gmail.com,
        eric.dumazet@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Subject: Re: [syzbot] WARNING in mroute_clean_tables
Message-ID: <20220608130512.49c35034@kernel.org>
In-Reply-To: <0000000000006097c505e0f48aa2@google.com>
References: <0000000000009962dc05d7a6b27f@google.com>
        <0000000000006097c505e0f48aa2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jun 2022 12:16:21 -0700 syzbot wrote:
> This bug is marked as fixed by commit:
> ipmr,ip6mr: acquire RTNL before calling ip[6]mr_free_table()
> But I can't find it in any tested tree for more than 90 days.
> Is it a correct commit? Please update it by replying:
> #syz fix: exact-commit-title
> Until then the bug is still considered open and
> new crashes with the same signature are ignored.

#syz fix: ipmr,ip6mr: acquire RTNL before calling ip[6]mr_free_table() on failure path
