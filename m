Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795D7C19F29
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Aug 2022 02:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbiHDCe4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 22:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiHDCet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E1A5FAF1;
        Wed,  3 Aug 2022 19:34:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E76A61790;
        Thu,  4 Aug 2022 02:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94410C433C1;
        Thu,  4 Aug 2022 02:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659580486;
        bh=2bSjUCVSOdvDJPYhExc2ULwhAVVJRZVuYhXgnRtbhtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kGxq9CUI6c2GC2yFu+9dNXBexIDrJz9dghg7U+Iz94Z2ejreR/71TZZk+8KTXM0vo
         bPueIpbyRJSyecSV80DOUiYcEluGdX5wUED9AYjK8duLOv0wlX1QANChDup85SvUVg
         PHGjJfAAnaoaJ4/VwTPj230uFTzmPoZIWJR6DAMhu+IuCqGazHh8YhRioPc1vogHR9
         EYb8BDkMqwbDp9qlEsglQVr/gZiqQuIuRzqNjtZweUt7/Dn2uJKWO1Vyz0GSJvirwj
         f9JgqQ29yraHCwSr+1ZhpUxXBeADbqE2KeiOZoZhbxx7VYjJl6utAkesCkNR/Oxazf
         Fs78coRqfXo5A==
Date:   Wed, 3 Aug 2022 19:34:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <richardcochran@gmail.com>, <claudiu.beznea@microchip.com>,
        <andrei.pistirica@microchip.com>, <edumazet@google.com>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <harinikatakamlinux@gmail.com>, <michal.simek@amd.com>,
        <harini.katakam@amd.com>, <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH 0/2] Macb PTP enhancements
Message-ID: <20220803193444.3b43730d@kernel.org>
In-Reply-To: <20220802104346.29335-1-harini.katakam@xilinx.com>
References: <20220802104346.29335-1-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2022 16:13:44 +0530 Harini Katakam wrote:
> From: Harini Katakam <harini.katakam@amd.com>
> 
> This series is a follow up for patches 2 and 3 from a previous series:
> https://lore.kernel.org/all/ca4c97c9-1117-a465-5202-e1bf276fe75b@microchip.com/
> https://lore.kernel.org/all/20220517135525.GC3344@hoboy.vegasvil.org/
> Sorry for the delay.
> 
> ACK is added only to patch 3 (now patch 2).
> Patch 1 is updated with check for gem_has_ptp as per Claudiu's comments.

These were separated from the earlier series as non-fixes, right?
But we are in the period of merge window right now, when all the
new features flow to Linus's tree and we only take fixes to avoid
conflicts and give maintainers time to settle the existing ones.
So these need to wait until -rc1 is cut. (Or is patch 1 a bug fix? 
I can't tell.)
