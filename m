Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D31C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 11:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356765AbiDCLEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356758AbiDCLEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:04:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C031900
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FE2661026
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 11:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6064CC340F0;
        Sun,  3 Apr 2022 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648983731;
        bh=9SCuE8ZRMM8SSbyjqF5vHEZZc/1AnIaETIaMMFdfFfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJ0me34fjQ1ZoK9fF8ZRWkicTNHqFI87TWBvOYp4n3r7IeOB95VerJ/n/6LTuKSSF
         KnKbVIgulOzwye/ClNYUcPiCJvi7menc5wTIiROIW3kQtwdPjc7zVJyjJgxX/IqjH1
         Qi/Emq0j5hzmwuTj48NHA7TNb8yxKGqkRMiKn4fM=
Date:   Sun, 3 Apr 2022 13:02:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, jerome.pouiller@silabs.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: remove space at the start of a line
Message-ID: <Ykl+scHFIh8ZG9c0@kroah.com>
References: <20220402114831.14977-1-eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402114831.14977-1-eng.alaamohamedsoliman.am@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 01:48:31PM +0200, Alaa Mohamed wrote:
> Fix " WARNING: please, no spaces at the start of a line"
> Reported by checkpatch
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>  drivers/staging/wfx/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> index b93b16b900c8..e575a81ca2ca 100644
> --- a/drivers/staging/wfx/main.c
> +++ b/drivers/staging/wfx/main.c
> @@ -170,7 +170,7 @@ bool wfx_api_older_than(struct wfx_dev *wdev, int major, int minor)
>   *
>   * The PDS file is an array of Time-Length-Value structs.
>   */
> - int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
> +int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
>  {
>  	int ret, chunk_type, chunk_len, chunk_num = 0;
>  
> -- 
> 2.35.1
> 
> 

Does not apply to my tree :(
