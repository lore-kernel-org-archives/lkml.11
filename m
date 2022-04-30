Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0789C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Apr 2022 02:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382055AbiD3CG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Apr 2022 22:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382034AbiD3CGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 22:06:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70C7D17DC;
        Fri, 29 Apr 2022 19:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CF7E62446;
        Sat, 30 Apr 2022 02:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFF5C385A4;
        Sat, 30 Apr 2022 02:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651284183;
        bh=4fodOr6PQd0npTQQlpzwa5pjqCRxnxx6nu4YxhAdv7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cmgSl0hIFl+St8mJd1KyEbKtOPyP8XclgU0uCtJ0g8/iB+FNfqRRF4Up9Hm7Emn+W
         9KbKNfjMI9DN4vtreSXp5VYyPFW6FjCaQH3TBnNiggNhKIzi5+uhRvawOKpmX/TsyR
         RbAVY7+cEUiS6vLKfAMz+rxOsKa78WEhBRxDVaFLrPTKF2Hz7KpO7LNfxUqvYg4Fhp
         yPzcOxQAz2F3BgBKmrnj9SVlXVbD6eJbXM4c7zAMcmnR8xFckxqJXwmga/EYtTwsb5
         YsjoudrwQNipYI9897ugHl2aE4UoizISPfGom2ABKzESAA9wi8rAwhPOmqgl/CbSqW
         tlTG/doI5bXGg==
Date:   Fri, 29 Apr 2022 19:03:01 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <michal.simek@xilinx.com>, <andrew@lunn.ch>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>
Subject: Re: [PATCH net v2 0/2] emaclite: improve error handling and minor
 cleanup
Message-ID: <20220429190301.70b1be60@kernel.org>
In-Reply-To: <1651261770-6025-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1651261770-6025-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2022 01:19:28 +0530 Radhey Shyam Pandey wrote:
> This patchset does error handling for of_address_to_resource() and also
> removes "Don't advertise 1000BASE-T" and auto negotiation.

Appears not to apply to net.
