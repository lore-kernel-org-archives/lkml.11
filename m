Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3C7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 01:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244222AbiDKBGy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 21:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiDKBGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 21:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B555B02;
        Sun, 10 Apr 2022 18:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FEEF60F2B;
        Mon, 11 Apr 2022 01:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D70BC385A4;
        Mon, 11 Apr 2022 01:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649639078;
        bh=7QJJSZyCBpHfoYkNWrOMYRfkaDkXvb2Tgsoch+Pp1DA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qSt4mL6CVa4I1dtd8eO0FqmPiNHjgvwFYPubmbrnIU93EesV7BRlLbDqF6L/iz4fY
         NkwgX/QIeWqOx0QXMPKXQ5tpTET32b2BmmTUdMXNOyoXx8MaEYhWoTsseGfnXiFo4y
         oW9FOqqL7rWDQONH51IeX7DNU5Cm/5hc0nboZBkQzKJ4O+l9N4kj6RquAD34k5CIq3
         ur+H4VRd12LkLLTiFhaNuNBrFIH80yRdJ7o8aGir7rvncvVhir9L1svYJZ2Bz0Eulg
         6wV0TRbIB7gfaK6gwBhnW3h6+FPjTTc1a53uAh0V3YQqhUemCptGEQY6nRoiESmPk2
         MnOlJ9ikzLVsQ==
Date:   Mon, 11 Apr 2022 09:04:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: lx2160a: Update can node property
Message-ID: <20220411010433.GY129381@dragon>
References: <20220402190855.35530-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402190855.35530-1-singh.kuldeep87k@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 12:38:55AM +0530, Kuldeep Singh wrote:
> fsl,clk-source property is of type uint8 and need to be defined as
> "/bits/ 8 <0>". Simply setting value to 0 raise warning:
> can@2180000: fsl,clk-source:0: [0, 0, 0, 0] is too long
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>

Applied, thanks!
