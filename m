Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DE9C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 01:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiGFBdn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 21:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGFBdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 21:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C3B1166;
        Tue,  5 Jul 2022 18:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E382617F7;
        Wed,  6 Jul 2022 01:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671BFC341C7;
        Wed,  6 Jul 2022 01:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657071219;
        bh=tXEAZbbXq7CDfjwXrTIalrmS21O6jO7l8pSeMA9eCHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gkjUQNVS3u/Ex/MmEc3uAl7KIt0dBzdCHd87d3Os/WzjETTZEa+8zBF/CnPb5TdyZ
         Ct7k1VIyZeRTkW36Pm90AB68DT/gR5cB+vRgb3VwOCFdvL6JboI4v07C7D9I4fy47h
         8XeTV69IcbJopNUFIvUeVqg5Xig0IDBKfAXVgsVL2Vb1qdqgCrOph+zqcrMecolQCB
         qqxTOJR8EohJ8artUd/9opfx7mNi0Vdsgy8WPkv7dWC9cCvtMhXt9+J61RVBZ3jbsv
         jPPm/6oU891QpMvBR19g99t8LdrfwumD575JiHrqBGSjmsqDEj/E5QkqaRpvPc/KSk
         TML4vpA0F76Bw==
Date:   Tue, 5 Jul 2022 18:33:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [PATCH 02/12] octeontx2-af: Exact match support
Message-ID: <20220705183338.375b948d@kernel.org>
In-Reply-To: <20220705104923.2113935-3-rkannoth@marvell.com>
References: <20220705104923.2113935-1-rkannoth@marvell.com>
        <20220705104923.2113935-3-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 16:19:13 +0530 Ratheesh Kannoth wrote:
> Change-Id: Id9f72c1d9e08b44eef45b67e52fe2fd2a0e7e535

Please drop the change ids
