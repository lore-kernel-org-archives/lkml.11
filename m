Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF8DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 18:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346761AbiDOSgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbiDOSgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:36:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45F661A00;
        Fri, 15 Apr 2022 11:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67EBFB82E24;
        Fri, 15 Apr 2022 18:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1893EC385A4;
        Fri, 15 Apr 2022 18:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650047617;
        bh=4c45x0cFrDaNl7E6QZRWWzeu+SgtTvnwghr1nJMHvUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I6MCCM8rDNjt8RkYYIunNbFQvtLqiNSMlcKfEWMcjNMK7w3jD6JhkN/qPVxJpHpfs
         LIfMpAefcP14zdaWeArkG3CbSDz6dcMTc+p6vCk83rJr64M7MFzUReDIlUVwyMT5Sx
         pAL9WlBVFhmspk8AO/ICX5TZMXPkWIbnbECW80LmTxo6099pHM9p+sqN38i1I4bAwG
         DHf0UMNgJUyc5qnbtTajhMGeqFi5sLEDRmCnCqJ1oDvuwHIL8NtJBCsqc0sfiRRJrh
         Vkib+NvVABsHQ2btqYZtzyoYMqJmBvg5CN+3zVUU/tiwLRQ+Hvcjw7HAhq9cZM4K4o
         3OjGl42+W2XVw==
Date:   Fri, 15 Apr 2022 20:33:30 +0200
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arun Ramadoss <arun.ramadoss@microchip.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, <UNGLinuxDriver@microchip.com>
Subject: Re: [Patch net-next v2 0/2] add ethtool SQI support for LAN87xx T1
 Phy
Message-ID: <20220415203330.5ac70f30@kernel.org>
In-Reply-To: <20220413065557.12914-1-arun.ramadoss@microchip.com>
References: <20220413065557.12914-1-arun.ramadoss@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 12:25:55 +0530 Arun Ramadoss wrote:
> This patch series add the Signal Quality Index measurement for the LAN87xx and
> LAN937x T1 phy. Updated the maintainers file for microchip_t1.c.

Please rebase and repost now that the fix also made its way to net-next.
The line numbers don't much and the way git deals with it is not
inspiring confidence.
