Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E05C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 02:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848396AbiDFCVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 22:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbiDEUpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 16:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7F4D9E96;
        Tue,  5 Apr 2022 13:22:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD8E06199D;
        Tue,  5 Apr 2022 20:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9CFC385A1;
        Tue,  5 Apr 2022 20:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649190137;
        bh=iNf3u//RenbgIFD6vj3Jlm5LNBRvGuu8NWlmRuWq0qE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SkmD42vtbSHd30A4rLpk505UkLToZ1JOL27KNWGrdX3+Th2p3HigyrKagdqOzC+j/
         IprKIn2kyiw1FDtrDhsCCMnUC072toB7ipOp5UdMH7HA0qh/iCaRh/Dn72HoiThjbb
         BVF6MqSZDf+9Nk8jmNqzqkjHIgIeeUpUAQ7/sblYQsQz7qTqiijihx/OtHYHlaPPXl
         /F8a1K5lpHdDKEkSL58JBHgHSIabYsUVpwf/hmN2DlknMQ0IHwFH+iLaileIPcA9Iz
         463uGYiXGFjA+yevyWV/QDfXd/kE6L4W6JLVZjNeY2o5lhu3VOmfCyo9iTPUzCuBxa
         z637LY13YaW4w==
Date:   Tue, 5 Apr 2022 13:22:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] sungem: Prepare cleanup of powerpc's
 asm/prom.h
Message-ID: <20220405132215.75f0d5ec@kernel.org>
In-Reply-To: <fa778bf9c0a23df8a9e6fe2e2b20d936bd0a89af.1648833433.git.christophe.leroy@csgroup.eu>
References: <fa778bf9c0a23df8a9e6fe2e2b20d936bd0a89af.1648833433.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Apr 2022 12:17:13 +0200 Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up, first add missing headers in
> users of asm/prom.h

Could you resend the net-next patches you had?

They got dropped from patchwork due to net-next being closed during 
the merge window.
