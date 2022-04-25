Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E226CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 15:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbiDYPvk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiDYPvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:51:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0670114817;
        Mon, 25 Apr 2022 08:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 41FE4CE1147;
        Mon, 25 Apr 2022 15:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EF6C385A4;
        Mon, 25 Apr 2022 15:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650901711;
        bh=/t9m4/CeRlKdtuZXaz3TIf1SxEIJdA7erFumgZsS0uw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eOh7UZUkEZo/3ZbQ3PFG7Sonks6El6PeCIN27QpESDKgQAErhvEaXm5KHbAphkzpI
         DbS3z0A806wbIW0q73FkzHUMYhjAKBeCDh22sXJeY2YzhqKHBIkrAOTHC9v2TOudcQ
         cnwD6Y+fV1mnE5tfBuHuBckGxp0n4CdDkY99FAwiw/YJLCMLdSsUKXPVdUb6YxF/MJ
         WtdvWJVvQhKG92F8KUwLIgbkDI6QRXTjwKXys/e3UTkxJ6wwqrn8LRrY7HQmI3at9V
         N4YKmmmQD26s3s3ouZxl4FixIONGLzDT6vjUa0tao1QuHX5QadQY8M9RZKdf+Qr63O
         8rWNcE/MfKKyQ==
Date:   Mon, 25 Apr 2022 08:48:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     netdev@vger.kernel.org, outreachy@lists.linux.dev,
        roopa@nvidia.com, jdenham@redhat.com, sbrivio@redhat.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, pabeni@redhat.com, vladimir.oltean@nxp.com,
        claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
        shshaikh@marvell.com, manishc@marvell.com, razor@blackwall.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, GR-Linux-NIC-Dev@marvell.com,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH net-next v4 0/2] propagate extack to vxlan_fdb_delete
Message-ID: <20220425084829.4b446748@kernel.org>
In-Reply-To: <cover.1650896000.git.eng.alaamohamedsoliman.am@gmail.com>
References: <cover.1650896000.git.eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 16:25:05 +0200 Alaa Mohamed wrote:
> In order to propagate extack to vxlan_fdb_delete and vxlan_fdb_parse,
> add extack to .ndo_fdb_del and edit all fdb del handelers

Your patches do not apply cleanly to net-next/master. Please rebase and
repost. Please wait 24h between postings to allow additional feedback
to come in.
