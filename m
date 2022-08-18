Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9168AC32773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 18:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343840AbiHRS0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 14:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiHRS0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE36EE12;
        Thu, 18 Aug 2022 11:26:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 850296173C;
        Thu, 18 Aug 2022 18:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ED3C433C1;
        Thu, 18 Aug 2022 18:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660847198;
        bh=OFGnpcwrWeELv7FvqlPB3WGEEDlwoiKUAr9DU0DKoJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I9aUYb1jF94RMiqSLSUdsR694a7U959Ieqlmgpa30XQ/kD30Yj8H0jchluhMBOCBF
         X3Jgz+CC0eztONEed9XjvVOdkAiVixR0r4YKKsHCVw5IzUMKQrfztzGmjDNMCYKQ5K
         ZacNzrR5A3wQe8SQlyk59N6V4lIHNlCQ1klnfwWMT2EelFF1P8sw8ROCwZgmls46nM
         F7/HyyxTA/eshnvwg1JfYyv+vL3vXLt0rZUutmZwCE5KIMd/76hPAC/mThm9FY4kZV
         +CTYBP1fL7Yn2dKFA9h+6kxt3XSO4Qtrb6dQL25ddy2e5omeaMbstf1LYVDbBEVdGQ
         cibEnUpe1fBWQ==
Date:   Thu, 18 Aug 2022 11:26:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Manish Chopra <manishc@marvell.com>
Cc:     Bruno Goncalves <bgoncalv@redhat.com>,
        Ariel Elior <aelior@marvell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        Alok Prasad <palok@marvell.com>
Subject: Re: [EXT] Re: RIP: 0010:qede_load+0x128d/0x13b0 [qede] - 5.19.0
Message-ID: <20220818112637.58101fe6@kernel.org>
In-Reply-To: <BY3PR18MB4612295606F0C22A1863FF44AB6D9@BY3PR18MB4612.namprd18.prod.outlook.com>
References: <CA+QYu4qxW1BUcbC9MwG1BxXjPO96sa9BOUXOHCj1SLY7ObJnQw@mail.gmail.com>
        <20220802122356.6f163a79@kernel.org>
        <CA+QYu4ob4cbh3Vnh9DWgaPpyw8nTLFG__TbBpBsYg1tWJPxygg@mail.gmail.com>
        <20220803083751.40b6ee93@kernel.org>
        <CA+QYu4poBJgXZ=RLTpQVxMeTX3HUSenWA7WZCcw45dzdGeyecg@mail.gmail.com>
        <20220818085106.73aabac2@kernel.org>
        <BY3PR18MB4612295606F0C22A1863FF44AB6D9@BY3PR18MB4612.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 17:55:28 +0000 Manish Chopra wrote:
> 3. You mentioned about commit 3aa6bce9af0e ("net: watchdog: hold device global xmit lock during tx disable")

FWIW that was just my guess based on the stack trace, Bruno posted the
stacktraces with line numbers decoded here:

https://lore.kernel.org/all/CA+QYu4ob4cbh3Vnh9DWgaPpyw8nTLFG__TbBpBsYg1tWJPxygg@mail.gmail.com/

>     Do you mean issue started surfacing only after this commit ? Driver calls netif_tx_disable() from these two relevant contexts -
> 
>     a. One in ndo_stop() flow 
> 
>       	        /* Close OS Tx */
>         netif_tx_disable(edev->ndev);
>         netif_carrier_off(edev->ndev);
>    
>    b. Other in LINK events handling from the hard IRQ context
> 
>         DP_NOTICE(edev, "Link is down\n");
>         netif_tx_disable(edev->ndev);
>         netif_carrier_off(edev->ndev);

