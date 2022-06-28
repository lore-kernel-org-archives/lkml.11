Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A08C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 05:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244702AbiF1FD2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 01:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244642AbiF1FDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:03:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8122658;
        Mon, 27 Jun 2022 22:03:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEAE261780;
        Tue, 28 Jun 2022 05:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063E4C3411D;
        Tue, 28 Jun 2022 05:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656392602;
        bh=s/7UWRYpLNUITYD4Wah1llQ/DrnlsZ0gFSv13KA7h6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W4rXtpZHkv38bXRfm/+E02LvOynFeIny21L3ij7CYmF5SWwGyosG5jhvShp4G2GCu
         evXFmVMlFkEnnG/FDzOGI+rB9pukBEXli4LLapSxuEATLZL9Zl7ywX4atOvGQJHVQk
         GxYEYCOAASu2+/GYJSD/5Mjhg8DwwyV3sksfc+ADVtKNO4A5SYxSGL/C8ne89noPtT
         n8tUQJ5PhNupwxjWME/lfXlJ8ctVfnDGWTjhHY1+2uO1+W5JUjQztDUPIny2+bHmAz
         QnGFymwIg273ShSsvy0BhKWYAr28DBV6e3+HPBz6TDp9K2BIek+IfgIHL14Z6wuAEc
         afa1RHIwC/2iw==
Date:   Mon, 27 Jun 2022 22:03:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Charles Gorand <charles.gorand@effinnov.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?Q2zDqW1lbnQ=?= Perrochaud <clement.perrochaud@nxp.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] NFC: nxp-nci: Don't issue a zero length
 i2c_master_read()
Message-ID: <20220627220320.29ca05ec@kernel.org>
In-Reply-To: <20220626194243.4059870-2-michael@walle.cc>
References: <20220626194243.4059870-1-michael@walle.cc>
        <20220626194243.4059870-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2022 21:42:43 +0200 Michael Walle wrote:
> There are packets which doesn't have a payload. In that case, the second
> i2c_master_read() will have a zero length. But because the NFC
> controller doesn't have any data left, it will NACK the I2C read and
> -ENXIO will be returned. In case there is no payload, just skip the
> second i2c master read.

Whoa, are you using this code or just found the problem thru code
inspection? NFC is notorious for having no known users.
