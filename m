Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37349C19F21
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 03:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbiG0DIS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 23:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiG0DIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:08:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF043CBE7;
        Tue, 26 Jul 2022 20:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4FFD6178C;
        Wed, 27 Jul 2022 03:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04545C433B5;
        Wed, 27 Jul 2022 03:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658891285;
        bh=rrVbm9MjvWNWGF4U6htlVR3G1Dk89mFVhmK84x/OQow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NShsH3WHnxrLYDeuXj1E2gGesSrtwtAP+QUrECFeyTLNRzn9wkLoXVCZw2XpDpsH+
         npCJVpvtM3al77swt+iH2qUixtZLrXtEtqpiRSDVyZOixglh4tn7/4F/MkT73yYC5P
         PkWaKL2XC2fgsucr03hJ8obNy7znJ0P6x+9IP4fcPFyq7Y/EIhfwSY0b5X/Alkoiy2
         mkdrbjgYzls5ArDvthj5PZidJIGT7kUItlB5jHTFtmYX49Ag4DLWCIHjl1TMjKkIYW
         5kjZryiRApn3/2V5NLBNa+yd/pEJ6j6vAi0TCixQE/VUDfm+NcI6YZAmITUga7j7yV
         7kYsHAeF6b3Jg==
Date:   Tue, 26 Jul 2022 20:08:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Geetha sowjanya <gakula@marvell.com>,
        Tariq Toukan <tariqt@nvidia.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Use only non-isolated cpus in
 irq affinity
Message-ID: <20220726200804.72deb465@kernel.org>
In-Reply-To: <20220725094402.21203-1-gakula@marvell.com>
References: <20220725094402.21203-1-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 15:14:02 +0530 Geetha sowjanya wrote:
> This patch excludes the isolates cpus from the cpus list
> while setting up TX/RX queue interrupts affinity
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>

Hm, housekeeping_cpumask() looks barely used by drivers,
do you have any references to discussions indicated drivers
are expected to pay attention to it? Really seems like something 
that the core should take care of.

Tariq, thoughts?
