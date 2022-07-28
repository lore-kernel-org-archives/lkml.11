Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC37C19F2B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 16:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiG1Q2y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiG1Q2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:28:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59767422C9;
        Thu, 28 Jul 2022 09:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B4C861CAE;
        Thu, 28 Jul 2022 16:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89075C433D6;
        Thu, 28 Jul 2022 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659025729;
        bh=flk0o6nSK99VFK94gMylMqFD/eSuV/X2NrwYji5XewI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g1jLPEpmz+EnFx8onEbBKR3YgZtrTWao/IomWCYnLrRNYd864I4dXAi3ofyDg2zIo
         BU6mBMhQMMH0DQ7olowgJfiZMrls01PkcTXhhtfjj7hBJvkOUVf79SFPoaaZlBh8sQ
         FERNpGu1Ni56zuFD8OXacswL+2hATG8DprVBKN1TEIlohBIvp3WFIYQfds78SkzoBD
         xF08zlxARIsDvcjHIg0Ve4DhLDq+O1+HkwHfzkdNmyCnBJYVSf3ivkpA6PLN/FzXpc
         p8E0QWJvPLaf6ACxzLXl5Hf6Qz6Q1reOAgXS8GMHe82jqFn76wP1S4KuapfeFTsomq
         yOnEg6BNWvqCg==
Date:   Thu, 28 Jul 2022 09:28:48 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Antonio Quartulli <antonio@openvpn.net>
Cc:     Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/1] net: introduce OpenVPN Data Channel Offload
 (ovpn-dco)
Message-ID: <20220728092848.36c6ccd5@kernel.org>
In-Reply-To: <c490b87c-085b-baca-b7e4-c67a3ee2c25e@openvpn.net>
References: <20220719014704.21346-1-antonio@openvpn.net>
        <20220719014704.21346-2-antonio@openvpn.net>
        <YtbNBUZ0Kz7pgmWK@lunn.ch>
        <c490b87c-085b-baca-b7e4-c67a3ee2c25e@openvpn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 09:41:11 +0200 Antonio Quartulli wrote:
> However, I guess I will still fill MODULE_VERSION() with a custom 
> string. This may also be useful when building the module out-of-tree.

Please use the kernel versions for versioning the out of tree code.
Whenever a new release is cut upstream you bump the number
appropriately in oot, and adjust whatever compat code needs adjusting. 
