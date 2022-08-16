Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABA5C25B0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 11:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiHPLuJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 07:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiHPLto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:49:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C46578A4;
        Tue, 16 Aug 2022 04:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A3A1B816AC;
        Tue, 16 Aug 2022 11:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5F2C433D6;
        Tue, 16 Aug 2022 11:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660649070;
        bh=d3dSBKh2SrlIBGWtAQb2uR6TaYJZ1lQAmF4VF8hXQPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmiDRML9pAEzQ5iWYFs/fobEI7USHXBWnMA59Baq+u/7N63Y5M6FO0924CZrv2dKb
         g6EHvkStn8bz+UcG+VZqeOcxi2uEpqdMZICVoBsagWoZuNqtRlsh5iujQgFww8rbVd
         FRcHENZJgVxnEurstTQ1IV8SqZ7yzTT44DGqaLPs=
Date:   Tue, 16 Aug 2022 13:24:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v4] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <Yvt+a1kBLWmBgWXl@kroah.com>
References: <20220816105502.9059-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816105502.9059-1-chensiying21@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 06:55:02PM +0800, Szuying Chen wrote:
> @@ -527,6 +539,7 @@ int tb_port_state(struct tb_port *port)
>  {
>  	struct tb_cap_phy phy;
>  	int res;
> +
>  	if (port->cap_phy == 0) {
>  		tb_port_WARN(port, "does not have a PHY\n");
>  		return -EINVAL;
> @@ -556,6 +569,7 @@ int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged)
>  {
>  	int retries = 10;
>  	int state;
> +
>  	if (!port->cap_phy) {
>  		tb_port_WARN(port, "does not have PHY\n");
>  		return -EINVAL;
> @@ -653,6 +667,7 @@ int tb_port_add_nfc_credits(struct tb_port *port, int credits)
>  int tb_port_clear_counter(struct tb_port *port, int counter)
>  {
>  	u32 zero[3] = { 0, 0, 0 };
> +
>  	tb_port_dbg(port, "clearing counter %d\n", counter);
>  	return tb_port_write(port, zero, TB_CFG_COUNTERS, 3 * counter, 3);
>  }
> @@ -875,6 +890,7 @@ static inline bool tb_switch_is_reachable(const struct tb_switch *parent,
>  					  const struct tb_switch *sw)
>  {
>  	u64 mask = (1ULL << parent->config.depth * 8) - 1;
> +
>  	return (tb_route(parent) & mask) == (tb_route(sw) & mask);
>  }
> 

These changes have nothing to do with your patch submission, and should
be a different patch entirely.

Remember, only do one-logical-thing per patch.

thanks,

greg k-h
