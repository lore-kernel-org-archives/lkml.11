Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8A0C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 20:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350561AbiFJUJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350511AbiFJUJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6C23D9B9;
        Fri, 10 Jun 2022 13:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4AFF60908;
        Fri, 10 Jun 2022 20:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B2AC341C0;
        Fri, 10 Jun 2022 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654891744;
        bh=iwnIUaWssTlHqycGijCDdgg7r32DPi0ilgri/+5YyAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RZqW19XiHxniX1vI+hPIGPdhpVzh1qA+4vF7yCUG5w3gttxIs0U64yy4B4ZWvXzHC
         GdSaR2FYi3wsghxQS7AEmdiBLt4qehKK/48UCZCGjEBE0b9Myh6imoUb2PposDfimo
         SLUK7XTxWnApGDRFTwkFX2gpuOD6OZBqB2UmVhXlIB3DfX0sQcHrBtpTKY5vaDo0Yp
         /hcXWudhme0PUKm5UKADcIohLrwmG44dl0+LnKJK2O4S3JDNhutsp4GHYJsVXyRnUB
         B/qAGDlZMQ0gew0+SggS0lbmhm+zSHVc+xlvUezvaH6TlPtJyQuOmkTuLjVcpW/iy6
         IBtewMQAhYCyg==
Date:   Fri, 10 Jun 2022 13:09:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 0/6] Configurable VLAN mode for NCSI driver
Message-ID: <20220610130903.0386c0d9@kernel.org>
In-Reply-To: <20220610165940.2326777-1-jiaqing.zhao@linux.intel.com>
References: <20220610165940.2326777-1-jiaqing.zhao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2022 00:59:34 +0800 Jiaqing Zhao wrote:
> Currently kernel NCSI driver only supports the "VLAN + non-VLAN" mode
> (Mode #2), but this mode is an optional mode [1] defined in NCSI spec
> and some NCSI devices like Intel E810 Network Adapter [2] does not
> support that mode. This patchset adds a new "ncsi,vlan-mode" device
> tree property for configuring the VLAN mode of NCSI device.
> 
> [1] Table 58 - VLAN Enable Modes
>     https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.0.0.pdf
> [2] 12.6.5.4.3 VLAN
>     https://cdrdv2.intel.com/v1/dl/getContent/613875

Please don't post the same patches more than once a day. You posted the
same patches 3 times within 15 minutes with no major difference :/

Why is "ncsi,vlan-mode" set via the device tree? Looks like something
that can be configured at runtime. 
