Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC34C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 15:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbiERPzU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 11:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbiERPzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A828F1CEED5;
        Wed, 18 May 2022 08:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 272D66148E;
        Wed, 18 May 2022 15:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE3DC385AA;
        Wed, 18 May 2022 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652889314;
        bh=fmlofeoDbX4MXR5lrxrHoH0vAAcURhh500zN4NdEn1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hO0z3Nio7OSHQsyZKgPl/EUrNFYoI/1985kUpU77iYhZeYkrxKEZ7E8Qtg4yDcQId
         QOACgwJkCp9LexELbT9gMeGhMdgdyDPAEI01Zo9mbBJGKsgD5yZ1rFhct0GVFtUDCO
         PmTIBUAPV/TkhOWgyrxhueyWh1GHwtEkETeoG/s5kAnbgYGZo9vPMBz9JocLEFbAtx
         g7lJp06sPuon9/PAsjaGqcTOS1TAvAdA03JEOjHtKoTsBn/lJj4Kvq1Xde3sVm6ALy
         7dlZbCFLyqr24mV8TurCyROUk3L13rlJtn0czRox+f3WFDx2EV3gobwO+Yad2ORBe/
         Eb3rFiZKGVFyA==
Date:   Wed, 18 May 2022 08:55:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <richardcochran@gmail.com>, <claudiu.beznea@microchip.com>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH net v2 0/2] Macb PTP one step fix
Message-ID: <20220518085512.00094bfd@kernel.org>
In-Reply-To: <20220518113310.28132-1-harini.katakam@xilinx.com>
References: <20220518113310.28132-1-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 17:03:08 +0530 Harini Katakam wrote:
> Split from "Macb PTP updates" series
> https://lore.kernel.org/netdev/20220517135525.GC3344@hoboy.vegasvil.org/T/
> - Fix Macb PTP one step.
> - Add common twoStepflag field definition.

The series does not apply cleanly to net:

  Applying: include: ptp: Add common two step flag mask
  Applying: net: macb: Fix PTP one step sync support
  Using index info to reconstruct a base tree...
  M	drivers/net/ethernet/cadence/macb_main.c
  Falling back to patching base and 3-way merge...
  Auto-merging drivers/net/ethernet/cadence/macb_main.c
  CONFLICT (content): Merge conflict in drivers/net/ethernet/cadence/macb_main.c
  error: Failed to merge in the changes.
  hint: Use 'git am --show-current-patch=diff' to see the failed patch
  Patch failed at 0002 net: macb: Fix PTP one step sync support


You need to rebase on top of this:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/

Also you can merge the patches together, no need to make the header
change separate.
