Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5035C28D13
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 02:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbiHWCCb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 22:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiHWCC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:02:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED7D4AD6E;
        Mon, 22 Aug 2022 19:02:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E610961219;
        Tue, 23 Aug 2022 02:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B659C433D6;
        Tue, 23 Aug 2022 02:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661220145;
        bh=0zd2q23nXWEvlrUZu+AFNEsTHBuLc+Aw04iOXfauH6g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gWpSEPGCAqt0j4wItIcDOljIjjFFLTel2IK8mGSyoMEfOyrPqCJYlXSCLZAagvxpz
         P8zo7EgS8zVbCMUuxDC9VNgtAqcuO7Km+k7LGoU2A+1WHRrrTIjXPSHx3SjbzR0Ajz
         coSsKnX44RMeoF7ER9YLyFjP8xHMU4raVe53bZlVOaEFn6k31ZTL3lFMkJn5Uq5Kk/
         Gy+ppZx06o0Ac/tT6YSX7heiiMkl5TSlHzYssdbqpQxgblckKEwRY9pOPUw0sEmf+0
         Lzrmuok2zxio5AtTAcU6aWnW3E5KmZI9ARrTB0MOHIeQsUOR8i+SjCyPbGTKZGugWT
         URRtrN/slew0w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220411100443.15132-2-shubhrajyoti.datta@xilinx.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com> <20220411100443.15132-2-shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v14 1/5] dt-bindings: add documentation of xilinx clocking wizard
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 22 Aug 2022 19:02:23 -0700
User-Agent: alot/0.10
Message-Id: <20220823020225.4B659C433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shubhrajyoti Datta (2022-04-11 03:04:39)
> Add the devicetree binding for the xilinx clocking wizard.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---

Applied to clk-next
