Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6D6C28D13
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 02:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbiHWCET (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 22:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbiHWCEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710FEF590;
        Mon, 22 Aug 2022 19:04:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 803BC611CD;
        Tue, 23 Aug 2022 02:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48D3C433C1;
        Tue, 23 Aug 2022 02:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661220248;
        bh=io8hhzyzf8QPk4tnNhUy/HqYvaAN+miYrgETdRj6PjU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DIYWdAsF+Yrgs8ZBqXsSmAkfXwyZ8DpKCczpmLiPO+y5zD6/6CmxYOXtIuZNKq06R
         W8ssjkiOpwD2AboicL5S0KOVHqfOlwYvIOWrEl41fXDglDJrBCZQIP1xchDdKbwpGJ
         8u2P+VGTXpFNMkqKXQxaY8RWpQbN1n6F5vJAB467GAtkNFKhMCpAOPkrjVmhuMNIjD
         vTzBIhAzPC/T2JrKib2Lit/2umC5JMohUz4hSPMoe19cfh7/gMr/WX34aSjM9b2kIS
         ++Nz7SNLMKlRiOyfqK2PZ8mTFONfs/9LT9EmdtX0CInvSQn0c9xZQm8dnO6Il3YS5E
         tvrNc/tl4IaBw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220411100443.15132-6-shubhrajyoti.datta@xilinx.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com> <20220411100443.15132-6-shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v14 5/5] clk: clocking-wizard: Update the compatible
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 22 Aug 2022 19:04:07 -0700
User-Agent: alot/0.10
Message-Id: <20220823020408.D48D3C433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shubhrajyoti Datta (2022-04-11 03:04:43)
> Update the compatible to indicate support for both 5.2 and 6.0
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---

Applied to clk-next
