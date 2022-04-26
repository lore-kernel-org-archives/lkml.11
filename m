Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA4DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 10:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349320AbiDZKqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 06:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349194AbiDZKqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:46:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A77263
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AC33B81B07
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B401DC385A4;
        Tue, 26 Apr 2022 10:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650969416;
        bh=/2cnCiOHmQ2L1SxXsGRXzghq2dTm9Xw8ROm5g+QBEIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVke7AQdbW+GxpoaFipFEsp+NitRKkgTd+UtCt4cPQ9lncyC8N9jMtbLLqCkz3UCn
         p+qmUSwjkIJE1YzS+aM0Jrc6dEycN3stoG2Yp1sCpL0e77nj6vgpsZfxLmNtuEqExY
         OQTWTBgrd6lzff7oZ5rKa+kliAJ9ZAaUe0zOjj+o=
Date:   Tue, 26 Apr 2022 12:36:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mcgrof@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v5 8/8] selftests: firmware: Add firmware upload selftests
Message-ID: <YmfLRU9mk2F1oLHb@kroah.com>
References: <20220421212204.36052-1-russell.h.weight@intel.com>
 <20220421212204.36052-9-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421212204.36052-9-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 02:22:04PM -0700, Russ Weight wrote:
> Add selftests to verify the firmware upload mechanism. These test
> include simple firmware uploads as well as upload cancellation and
> error injection. The test creates three firmware devices and verifies
> that they all work correctly and independently.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Tested-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - No changes from v1
> v3:
>   - Added Reviewed-by tag
> v4:
>   - Added Reviewed-by tag
> v5:
>   - Added Tested-by tag

This patch no longer applies to my branch.  Can you rebase and resend
it?  The others are now queued up, thanks.

greg k-h
