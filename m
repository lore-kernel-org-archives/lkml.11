Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987DFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 04:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbiCKEmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 23:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiCKEl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:41:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945BD1A8070;
        Thu, 10 Mar 2022 20:40:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FEC4B82A77;
        Fri, 11 Mar 2022 04:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89448C340EC;
        Fri, 11 Mar 2022 04:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646973652;
        bh=IRqFVrpyUqt1gWh3UlejHjKKJ5lWo3XyNfF+ss8+feQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vJDhLDo3FNR21w4iHUox8q/APrfcRVEb5nH+UN4+VzcaO9RYqiOGt3vqla7yXSgIn
         7FvXJqOBccD+qOuDUM6nlE1PKFuwjSNhMuvsMNDeobgy6MLDjW18Lar0vWFESqlDgo
         uwe19sOWTWVuJC9DpnSWz/MlFKHk9QBh0sNZEJQ0BNEDdH3ne08Pt1rITBTdtXGZJE
         3gsm0lbovQuvU3nQC/TcEy8igB8z7KLNJGRvhA4jyZNOyz/fw3vnj+61PZ5+J4M253
         KATIwgsADjxt8yOQnW8ny+gsznhANiy/3BDrpXr1SYIfbqlRqqIoTjZMDeIoppTDjG
         N7S7eMMVQitYw==
Date:   Thu, 10 Mar 2022 20:40:51 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        ralf@linux-mips.org, jreuter@yaina.de
Subject: Re: [PATCH V2] ax25: Fix NULL pointer dereferences in ax25 timers
Message-ID: <20220310204051.44c9555d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220310144347.102465-1-duoming@zju.edu.cn>
References: <20220310144347.102465-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 22:43:47 +0800 Duoming Zhou wrote:
> There are race conditions that may lead to null pointer dereferences in
> ax25_heartbeat_expiry(), ax25_t1timer_expiry(), ax25_t2timer_expiry(),
> ax25_t3timer_expiry() and ax25_idletimer_expiry(), when we use
> ax25_kill_by_device() to detach the ax25 device.

None of your last 4 patches applied to our trees.

If you're sending fixes for networking please base them on 
net/master and put [PATCH net] in the subject.
