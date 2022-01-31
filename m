Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922CDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Jan 2022 15:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379577AbiAaPba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Jan 2022 10:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379572AbiAaPbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:31:13 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9FBC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:31:13 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 35BC04DC; Mon, 31 Jan 2022 16:31:12 +0100 (CET)
Date:   Mon, 31 Jan 2022 16:31:11 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Vijayanand Jitta <quic_vjitta@quicinc.com>
Cc:     robin.murphy@arm.com, will@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vjitta@codeaurora.org
Subject: Re: [REPOST PATCH v4] iommu: Fix potential use-after-free during
 probe
Message-ID: <YfgAv0N/iTU39Ve0@8bytes.org>
References: <1643613155-20215-1-git-send-email-quic_vjitta@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643613155-20215-1-git-send-email-quic_vjitta@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:42:35PM +0530, Vijayanand Jitta wrote:
>  drivers/iommu/iommu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied, thanks Vijayanand.
