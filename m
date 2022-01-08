Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2ECC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jan 2022 17:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiAHR1t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jan 2022 12:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiAHR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:27:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B356C06173F;
        Sat,  8 Jan 2022 09:27:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39668B80758;
        Sat,  8 Jan 2022 17:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25034C36AE3;
        Sat,  8 Jan 2022 17:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641662864;
        bh=Tuky5CsIoFL7t3LXsnjkVvwIC2OZHiuk88zr23O/ljo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KnmXENx3ICoHP3ZW2UgwFsfl8MN8B2efd4/3ut6oSTXPugNbVbHyQM25wu97KUbnL
         oZOqZxXKk/fVx1tCOIXomMTK7pQnq6tWrS4k9QcS3Yxkt3hU5qgNvsTos2u8uvqCcm
         mOTEwOfiMS+5QPJzruIYa8L4hQJxy+ECVQQW/HT+6vAiIf6aCrVIzihZ8+oRZx/Wme
         cI/O9p2Yemuh62RZ7Fjx20zL9wkdjS/B56ms5oSnPBWhzKLr7Cc0oHcL2o+5xDlVR2
         eFHTF1sxcd41qxrKiLabslWqa0sjgV6yQZut/Dw9s4oXQkIMvqyZ77ghcHm/enJNkK
         U6R0azL1we2BA==
Date:   Sat, 8 Jan 2022 22:57:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma-controller: Split interrupt fields in
 example
Message-ID: <YdnJgGeVvXispYui@matsya>
References: <20220106182518.1435497-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106182518.1435497-2-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-01-22, 12:25, Rob Herring wrote:
> Best practice for multi-cell property values is to bracket each multi-cell
> value.

Applied, thanks

-- 
~Vinod
