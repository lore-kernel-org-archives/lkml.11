Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE96FC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 00:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379428AbiFQAdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiFQAdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CCB344EC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E577F61957
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457ADC34114;
        Fri, 17 Jun 2022 00:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655426031;
        bh=Esh5EYmgfGLBloTgln1krxz4ZH1WRfV3aIfx7d9WJ64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E179pDvm57ISo1teMtoafGuzlSVx2EgNMvTkW9jteKQr6vVJNp3qEQ7Zt0t8Au0I+
         CacbgYWXCMR90prDdukCidlb9yNZjwo2t0dBlkDuv81MwqTfqq3PT4JCLuKhwHAanD
         Ytq4fkL51vSp8IR0Hek0Lt/1ycRdhcoR3wvplXQKdwQFOWMXTptHeA6C2MuN69cf+L
         luobVp0V9Dx5DzO+GISzsVK2ry7zn9YMUdUPaxBM+DeBANXQetV8ce8P9iQ77zTs7d
         X/cVRb9w9yz9oYXLMedGAGB6AtAXIz4LCLOalczYV+YjuUkTdQ/EQKkSj6imUfbYb6
         OHTxj1Gt+ljow==
Date:   Thu, 16 Jun 2022 17:33:50 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     kishon@ti.com, mranostay@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: ti: phy-j721e-wiz: use OF data for device specific
 data
Message-ID: <YqvL7u5emkhqzEvj@matsya>
References: <20220526064121.27625-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526064121.27625-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-05-22, 09:41, Roger Quadros wrote:
> Move device specific data into OF data structure so it
> is easier to maintain and we can get rid of if statements.

Applied, thanks

-- 
~Vinod
