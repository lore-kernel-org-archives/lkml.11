Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22034C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 06:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiDVGEL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 02:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiDVGEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:04:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36EF4F473;
        Thu, 21 Apr 2022 23:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FC29B82A80;
        Fri, 22 Apr 2022 06:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB7DC385A0;
        Fri, 22 Apr 2022 06:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650607272;
        bh=3i1HFTIZEG8nOO9HFtaoGnljHf2PsNxcHh/XzjuJJkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jn1BvP4OQKlEKCcLQwC7JsFJCzcCvE4CAA6e6z5kKgZOjsQ8yQhJOoDvAyO8LPeAc
         BL1RuUre/GOA6bBedWs5fsSwxmld8zEN3VkBNDTFZgGtH9XAFKRvHPPmpCPcw7NepO
         ecUecJJiH5oABVTWd/iGyKGmSyso4JjsHlIgTFEnWrO5IEy6Ekm2fFvd35UMtirzWn
         hMQ/CkBN3RxORkEhxumExpf3zKGog/URyzJGXv0lvjsxsY/fbZXuNHHuKwpjXyAJ0f
         3DmKhvimNiLzu6FmQW4EImyUlY0/ct0ko4rnVF8r/+oInwsprm/mzChlC9OohS8yl4
         cmWMzi+6fQaUA==
Date:   Fri, 22 Apr 2022 11:31:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     dmaengine@vger.kernel.org, peter.ujfalusi@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-psil-am62: Update PSIL thread for saul.
Message-ID: <YmJEpMDGqo7eiVgu@matsya>
References: <20220421065323.16378-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421065323.16378-1-j-choudhary@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-22, 12:23, Jayesh Choudhary wrote:
> Correct the RX PSIL thread for sa3ul.

Applied, thanks

-- 
~Vinod
